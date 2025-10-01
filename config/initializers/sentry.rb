# frozen_string_literal: true

# Only initialize Sentry in staging and production environments
if Rails.env.staging? || Rails.env.production?
  Rails.logger.info "Initializing Sentry for #{Rails.env} environment"
  Rails.logger.info "SENTRY_DSN present: #{ENV['SENTRY_DSN'].present?}"

  Sentry.init do |config|
    # Read DSN from environment variable
    config.dsn = ENV['SENTRY_DSN']

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

    # Sample rate for performance monitoring (0.0 to 1.0)
    # 1.0 = 100% of transactions, 0.1 = 10% of transactions
    config.traces_sample_rate = Rails.env.production? ? 0.1 : 1.0

    # Sample rate for error events (0.0 to 1.0)
    config.sample_rate = 1.0

    # Set up custom tags for better filtering
    # Note: Tags are set per event, not globally in configuration

    # Configure which exceptions to ignore
    config.excluded_exceptions += [
      'ActionController::RoutingError',
      'ActionController::InvalidAuthenticityToken',
      'ActionDispatch::RemoteIp::IpSpoofAttackError',
      'Mime::Type::InvalidMimeType'
    ]


    # Configure logging level - Sentry will automatically use Rails.logger
    # No need to explicitly set config.logger

    # Set up custom context and tags
    config.before_send_transaction = lambda do |event, hint|
      # Add custom context to all transactions
      event.set_context('app_info', {
        version: Rails.application.class.module_parent_name.downcase,
        environment: Rails.env
      })

      # Set custom tags for better filtering
      event.set_tag('environment', Rails.env)
      event.set_tag('app', 'art_survey')

      event
    end

    # Set up custom context for error events
    config.before_send = lambda do |event, hint|
      # Add custom context to error events
      event.set_context('app_info', {
        version: Rails.application.class.module_parent_name.downcase,
        environment: Rails.env
      })

      # Set custom tags for better filtering
      event.set_tag('environment', Rails.env)
      event.set_tag('app', 'art_survey')

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
