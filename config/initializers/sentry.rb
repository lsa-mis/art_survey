# frozen_string_literal: true

# Only initialize Sentry in staging and production environments
if Rails.env.staging? || Rails.env.production?
  Rails.logger.info "Initializing Sentry for #{Rails.env} environment"
  Rails.logger.info "SENTRY_DSN present: #{ENV['SENTRY_DSN'].present?}"

  Sentry.init do |config|
    # DSN is automatically read from SENTRY_DSN environment variable
    config.enable_logs = true
    config.rails.structured_logging.enabled = true
    config.environment = Rails.env

    # Prefer an explicit deploy release; Capistrano often writes REVISION.
    config.release = ENV["SENTRY_RELEASE"].presence ||
                     Rails.root.join("REVISION").then { |path| path.read.strip if path.exist? }

    config.breadcrumbs_logger = [:active_support_logger, :http_logger]
    config.send_default_pii = true

    # Production: 10% of transactions, Staging: 100% for testing
    config.traces_sample_rate = Rails.env.production? ? 0.1 : 1.0
    config.sample_rate = 1.0

    config.excluded_exceptions += [
      "ActionController::RoutingError",
      "ActionController::InvalidAuthenticityToken",
      "ActionDispatch::RemoteIp::IpSpoofAttackError",
      "Mime::Type::InvalidMimeType"
    ]

    config.before_send = lambda do |event, _hint|
      event.tags = (event.tags || {}).merge(
        "environment" => Rails.env,
        "app" => "art_survey"
      )

      event.contexts = (event.contexts || {}).merge(
        "app_info" => {
          version: Rails.application.class.module_parent_name.downcase,
          environment: Rails.env
        }
      )

      if event.request&.data.is_a?(Hash)
        event.request.data = event.request.data.except("password", "password_confirmation", "token", "secret")
      end

      if event.request&.headers.is_a?(Hash)
        event.request.headers = event.request.headers.except("Authorization", "X-API-Key")
      end

      event
    end
  end
end
