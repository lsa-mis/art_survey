# This initializer patches ActiveStorage::Representations::RedirectController
# to include our blob caching concern to prevent repeated SQL queries

Rails.application.config.to_prepare do
  # Only apply the patch if the class exists
  if defined?(ActiveStorage::Representations::RedirectController)
    ActiveStorage::Representations::RedirectController.include(ActiveStorageBlobCache)
  end

  # Also patch the Blobs::RedirectController for direct blob access
  if defined?(ActiveStorage::Blobs::RedirectController)
    ActiveStorage::Blobs::RedirectController.include(ActiveStorageBlobCache)
  end
end
