# frozen_string_literal: true

# Only initialize Sentry in staging and production environments
if Rails.env.staging? || Rails.env.production?
  Sentry.init do |config|
    # Read DSN from environment variable
    config.dsn = ENV['SENTRY_DSN']

    # Set environment for better filtering in Sentry dashboard
    config.environment = Rails.env

    # Set release version (useful for tracking deployments)
    config.release = ENV['SENTRY_RELEASE'] || `git rev-parse HEAD`.strip rescue nil

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

    # Enable performance monitoring
    config.enable_tracing = true

    # Set up custom tags for better filtering
    config.tags = {
      environment: Rails.env,
      app: 'art_survey'
    }

    # Configure which exceptions to ignore
    config.excluded_exceptions += [
      'ActionController::RoutingError',
      'ActionController::InvalidAuthenticityToken',
      'ActionDispatch::RemoteIp::IpSpoofAttackError',
      'Mime::Type::InvalidMimeType'
    ]

    # Configure before_send to filter sensitive data
    config.before_send = lambda do |event, hint|
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

    # Configure logging level - Sentry will automatically use Rails.logger
    # No need to explicitly set config.logger

    # Set up custom context
    config.before_send_transaction = lambda do |event, hint|
      # Add custom context to all transactions
      event.set_context('app_info', {
        version: Rails.application.class.module_parent_name.downcase,
        environment: Rails.env
      })
      event
    end
  end
end
