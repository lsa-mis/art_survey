module ActiveStorageRepresentationCache
  extend ActiveSupport::Concern

  included do
    # This is a Rails HTTP cache policy: must be validated, but can be reused
    # even while stale, which helps during revalidation
    # https://api.rubyonrails.org/v7.0/classes/ActionController/ConditionalGet.html
    include ActionController::ConditionalGet

    # Only apply to the show action in controllers that handle ActiveStorage redirects
    before_action :apply_representation_cache, only: [:show]

    # Set the Rails.cache for 1 day (tunable via ENV var)
    class_attribute :representation_cache_expiration, default: ENV.fetch('REPRESENTATION_CACHE_TTL', 1.day).to_i
  end

  private

  def apply_representation_cache
    # Skip if we're not in the right controller or action
    return unless self.class.name.include?('ActiveStorage') &&
                  self.class.name.include?('RedirectController') &&
                  action_name == 'show'

    # Extract blob and variation keys from params or instance variables
    blob_id = params[:blob_id] || (defined?(@blob) && @blob&.id)
    variation_key = params[:variation_key] || extract_variation_key_from_signed_id

    return unless blob_id.present?

    cache_key = "active_storage/representation_redirect/#{blob_id}/#{variation_key}"

    # Try to find the response in the cache
    cached_response = Rails.cache.read(cache_key)

    if cached_response
      # If we have a cached redirect, use it directly without processing
      set_cache_headers
      redirect_to cached_response, allow_other_host: true
      return
    end

    # Add a callback to store the redirect URL in the cache
    self.class.after_action do
      if response.status.to_i >= 300 && response.status.to_i < 400
        # Get the redirect URL from the response
        redirect_url = response.headers['Location']
        if redirect_url.present?
          # Store the URL in the cache
          Rails.cache.write(cache_key, redirect_url, expires_in: representation_cache_expiration)
        end
      end
    end

    # Set HTTP caching headers
    set_cache_headers
  end

  def set_cache_headers
    # Set HTTP caching headers
    expires_in representation_cache_expiration, public: true
    # Enable conditional GET with ETag
    fresh_when etag: "representation_#{params[:blob_id]}_#{params[:variation_key] || params[:signed_id]}"
  end

  def extract_variation_key_from_signed_id
    # Try to extract the variation key from a signed ID if available
    return nil unless params[:signed_id].present?

    begin
      data = ActiveStorage.verifier.verify(params[:signed_id], purpose: :variation)
      data[:variation_key]
    rescue => e
      Rails.logger.debug "Could not extract variation key: #{e.message}"
      nil
    end
  end
end
