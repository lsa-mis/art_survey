require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load custom middleware
require_relative '../lib/active_storage_blob_cache_middleware'

module ArtSurvey
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Eastern Time (US & Canada)'
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    # run 'brew install vips' or uncomment the next line
    config.active_storage.variant_processor = :mini_magick

    # Add query caching for ActiveStorage blobs
    config.active_storage.queues.analysis = :active_storage_analysis
    config.active_storage.queues.purge    = :active_storage_purge

    # Enable caching for ActiveStorage blobs
    config.active_storage.track_variants = true

    # Add our custom middleware for ActiveStorage blob caching
    config.middleware.use ActiveStorageBlobCacheMiddleware
  end
end
