module ActiveStorageBlobCache
  extend ActiveSupport::Concern

  included do
    around_action :cache_active_storage_blobs, if: -> { action_name == 'show' }
  end

  private

  def cache_active_storage_blobs
    # Create a request-specific cache for blobs
    RequestStore.store[:active_storage_blobs] = {}

    # Monkey patch ActiveStorage::Blob.find to use our cache
    ActiveStorage::Blob.class_eval do
      class << self
        alias_method :original_find, :find

        def find(id)
          # Ensure the cache exists before trying to access it
          RequestStore.store[:active_storage_blobs] ||= {}
          RequestStore.store[:active_storage_blobs][id] ||= original_find(id)
        end
      end
    end

    yield

    # Restore original method after the request
    ActiveStorage::Blob.class_eval do
      class << self
        alias_method :find, :original_find
        remove_method :original_find
      end
    end
  rescue => e
    Rails.logger.error "ActiveStorageBlobCache error: #{e.message}"
    yield # Still process the request even if our caching fails
  end
end
