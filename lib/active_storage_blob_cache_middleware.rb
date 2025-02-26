class ActiveStorageBlobCacheMiddleware
  # Class variable to store original methods safely across requests
  @@original_methods = {}
  @@patched = false

  def initialize(app)
    @app = app
  end

  def call(env)
    # Only apply caching for ActiveStorage routes
    if env['PATH_INFO'].start_with?('/rails/active_storage')
      begin
        apply_patches unless @@patched
        with_request_store { @app.call(env) }
      rescue => e
        Rails.logger.error "ActiveStorage middleware error: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
        # Continue with the request even if patching fails
        @app.call(env)
      end
    else
      @app.call(env)
    end
  end

  private

  def apply_patches
    # Only patch once per application lifecycle
    return if @@patched

    # Store original methods if not already stored
    unless @@original_methods[:blob_find]
      @@original_methods[:blob_find] = ActiveStorage::Blob.method(:find)

      # Safely patch ActiveStorage::Blob.find
      ActiveStorage::Blob.define_singleton_method(:find) do |id|
        # Get request-specific cache or initialize it
        store = RequestStore.store[:active_storage_blobs] ||= {}

        # Return cached version or fetch and cache
        store[id] ||= begin
          # Call the stored original method with proper error handling
          original_find = @@original_methods[:blob_find]
          if original_find
            original_find.call(id)
          else
            # Fallback to normal behavior if original is missing
            Rails.logger.warn "Original Blob.find method missing, using fallback"
            ActiveStorage::Blob.find_signed(id) || ActiveStorage::Blob.where(id: id).first
          end
        rescue => e
          Rails.logger.error "Error in cached Blob.find: #{e.message}"
          # Try direct database lookup as last resort
          ActiveStorage::Blob.where(id: id).first
        end
      end
    end

    # Add other similar patches for representation and variant as needed
    patch_representation if defined?(ActiveStorage::Representation)
    patch_variant_record if defined?(ActiveStorage::VariantRecord)

    # Mark as patched to avoid reapplying
    @@patched = true
  end

  def patch_representation
    return if @@original_methods[:representation_find_by]

    @@original_methods[:representation_find_by] = ActiveStorage::Representation.method(:find_by)

    ActiveStorage::Representation.define_singleton_method(:find_by) do |**kwargs|
      store = RequestStore.store[:active_storage_representations] ||= {}
      cache_key = "#{kwargs[:blob_id]}-#{kwargs[:variation_id]}"

      store[cache_key] ||= begin
        original_find_by = @@original_methods[:representation_find_by]
        if original_find_by
          original_find_by.call(**kwargs)
        else
          # Fallback
          Rails.logger.warn "Original Representation.find_by method missing, using fallback"
          ActiveStorage::Representation.where(**kwargs).first
        end
      rescue => e
        Rails.logger.error "Error in cached Representation.find_by: #{e.message}"
        ActiveStorage::Representation.where(**kwargs).first
      end
    end
  end

  def patch_variant_record
    return if @@original_methods[:variant_find_or_create_by]

    @@original_methods[:variant_find_or_create_by] = ActiveStorage::VariantRecord.method(:find_or_create_by!)

    ActiveStorage::VariantRecord.define_singleton_method(:find_or_create_by!) do |blob:, variation:|
      store = RequestStore.store[:active_storage_variants] ||= {}
      variation_key = variation.key
      cache_key = "#{blob.id}-#{variation_key}"

      store[cache_key] ||= begin
        original_find_or_create = @@original_methods[:variant_find_or_create_by]
        if original_find_or_create
          original_find_or_create.call(blob: blob, variation: variation)
        else
          # Fallback
          Rails.logger.warn "Original VariantRecord.find_or_create_by! method missing, using fallback"
          ActiveStorage::VariantRecord.where(blob_id: blob.id, variation_digest: variation.digest).first_or_create! do |record|
            record.variation_digest = variation.digest
          end
        end
      rescue => e
        Rails.logger.error "Error in cached VariantRecord.find_or_create_by!: #{e.message}"
        # Try direct DB lookup/create as fallback
        ActiveStorage::VariantRecord.where(blob_id: blob.id, variation_digest: variation.digest).first_or_create! do |record|
          record.variation_digest = variation.digest
        end
      end
    end
  end

  def with_request_store
    # Initialize request-specific caches
    RequestStore.store[:active_storage_blobs] = {}
    RequestStore.store[:active_storage_representations] = {}
    RequestStore.store[:active_storage_variants] = {}

    # Process the request
    yield
  end
end
