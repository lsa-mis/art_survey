class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
  end

  # Sentry test endpoint - only available in staging and production
  def sentry_test
    if Rails.env.staging? || Rails.env.production?
      # Test Sentry error reporting
      Sentry.capture_message("Sentry test message from #{Rails.env}", level: :info)

      # Test Sentry exception reporting
      begin
        raise StandardError, "This is a test exception for Sentry monitoring"
      rescue StandardError => e
        Sentry.capture_exception(e)
      end

      render json: {
        message: "Sentry test completed successfully",
        environment: Rails.env,
        sentry_dsn_configured: ENV['SENTRY_DSN'].present?,
        timestamp: Time.current
      }
    else
      render json: { error: "Sentry test endpoint only available in staging and production" }, status: :not_found
    end
  end

end
