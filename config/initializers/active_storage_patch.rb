# This initializer is no longer needed as we're using the ActiveStorageBlobCacheMiddleware
# instead of patching the controllers directly.
#
# The middleware approach is more robust and less likely to cause issues.
# See lib/active_storage_blob_cache_middleware.rb for the implementation.

# Rails.application.config.to_prepare do
#   begin
#     # Only apply the patch if the class exists
#     if defined?(ActiveStorage::Representations::RedirectController)
#       ActiveStorage::Representations::RedirectController.include(ActiveStorageBlobCache)
#       Rails.logger.info "Successfully patched ActiveStorage::Representations::RedirectController"
#     end
#
#     # Also patch the Blobs::RedirectController for direct blob access
#     if defined?(ActiveStorage::Blobs::RedirectController)
#       ActiveStorage::Blobs::RedirectController.include(ActiveStorageBlobCache)
#       Rails.logger.info "Successfully patched ActiveStorage::Blobs::RedirectController"
#     end
#   rescue => e
#     Rails.logger.error "Failed to patch ActiveStorage controllers: #{e.message}"
#   end
# end
