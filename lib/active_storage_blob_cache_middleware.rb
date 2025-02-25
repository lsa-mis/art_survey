class ActiveStorageBlobCacheMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    # Only apply caching for ActiveStorage routes
    if env['PATH_INFO'].start_with?('/rails/active_storage')
      with_blob_caching { @app.call(env) }
    else
      @app.call(env)
    end
  end

  private

  def with_blob_caching
    # Initialize the cache
    RequestStore.store[:active_storage_blobs] = {}

    # Apply the monkey patch
    original_find = ActiveStorage::Blob.method(:find)

    ActiveStorage::Blob.define_singleton_method(:find) do |id|
      RequestStore.store[:active_storage_blobs] ||= {}
      RequestStore.store[:active_storage_blobs][id] ||= original_find.call(id)
    end

    # Process the request
    yield
  ensure
    # Restore the original method
    if original_find
      ActiveStorage::Blob.singleton_class.send(:define_method, :find, original_find)
    end
  end
end
