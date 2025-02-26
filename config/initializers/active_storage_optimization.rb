# This initializer patches the ActiveStorage controllers for better performance
# Focus is on optimizing the RedirectController which is a hotspot in performance monitoring

Rails.application.config.to_prepare do
  begin
    # Only apply if the concern and controller exist
    if defined?(ActiveStorageRepresentationCache) && defined?(ActiveStorage::Representations::RedirectController)
      ActiveStorage::Representations::RedirectController.include(ActiveStorageRepresentationCache)
      Rails.logger.info "Successfully patched ActiveStorage::Representations::RedirectController with caching optimizations"
    end

    # Also optimize the Blobs::RedirectController in the same way
    if defined?(ActiveStorageRepresentationCache) && defined?(ActiveStorage::Blobs::RedirectController)
      ActiveStorage::Blobs::RedirectController.include(ActiveStorageRepresentationCache)
      Rails.logger.info "Successfully patched ActiveStorage::Blobs::RedirectController with caching optimizations"
    end
  rescue => e
    Rails.logger.error "Failed to patch ActiveStorage controllers for optimization: #{e.message}"
  end
end
