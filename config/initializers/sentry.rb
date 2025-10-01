# frozen_string_literal: true

# Only initialize Sentry in staging and production environments
if Rails.env.staging? || Rails.env.production?
  Rails.logger.info "Initializing Sentry for #{Rails.env} environment"
  Rails.logger.info "SENTRY_DSN present: #{ENV['SENTRY_DSN'].present?}"

  Sentry.init do |config|
    # DSN is automatically read from SENTRY_DSN environment variable
    # config.dsn is set automatically by sentry-rails gem
    config.enable_logs = true
    config.rails.structured_logging.enabled = true
    # Set environment for better filtering in Sentry dashboard
    config.environment = Rails.env

    # Set release version (useful for tracking deployments)
    config.release = ENV['SENTRY_RELEASE'] || begin
      `git rev-parse HEAD`.strip
    rescue
      nil
    end

    # Enable breadcrumbs for better debugging context
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]

    # Add data like request headers and IP for users
    # see https://docs.sentry.io/platforms/ruby/data-management/data-collected/ for more info
    config.send_default_pii = true

    # Performance monitoring sample rate
    # Production: 10% of transactions, Staging: 100% for testing
    config.traces_sample_rate = Rails.env.production? ? 0.1 : 1.0

    # Error events sample rate (100% for all environments)
    config.sample_rate = 1.0

    # Configure which exceptions to ignore (Rails-specific)
    config.excluded_exceptions += [
      'ActionController::RoutingError',
      'ActionController::InvalidAuthenticityToken',
      'ActionDispatch::RemoteIp::IpSpoofAttackError',
      'Mime::Type::InvalidMimeType'
    ]

    # Set up custom context and tags for all events
    config.before_send = lambda do |event, hint|
      # Set custom tags for better filtering
      event.set_tag('environment', Rails.env)
      event.set_tag('app', 'art_survey')

      # Add custom context only if the event supports it
      if event.respond_to?(:set_context)
        event.set_context('app_info', {
          version: Rails.application.class.module_parent_name.downcase,
          environment: Rails.env
        })
      end

      # Remove sensitive parameters
      if event.request&.data
        event.request.data = event.request.data.except('password', 'password_confirmation', 'token', 'secret')
      end

      # Remove sensitive headers
      if event.request&.headers
        event.request.headers = event.request.headers.except('Authorization', 'X-API-Key')
      end

      event
    end
  end

  # Test Sentry initialization
  begin
    Sentry.capture_message("Sentry initialized successfully for #{Rails.env}", level: :info)
    Rails.logger.info "Sentry test message sent successfully"
  rescue => e
    Rails.logger.error "Failed to send Sentry test message: #{e.message}"
  end
end
