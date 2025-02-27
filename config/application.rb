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

    # Enable caching for ActiveStorage blobs and representations
    config.active_storage.track_variants = true

    # Representation URLs will be persistent and cacheable for 24 hours by default
    # This helps with CDN caching and browser caching
    # You can override this in each environment file or via ENV['REPRESENTATION_CACHE_TTL']
    config.active_storage.resolve_model_to_route = :rails_storage_redirect

    # Add explicit support for parallel processing
    config.active_storage.multiple_file_field_include_hidden = true

    # Precompute variations on upload if possible
    config.active_storage.precompile_variants_on_upload = true if Rails.env.production? || Rails.env.staging?
  end
end
