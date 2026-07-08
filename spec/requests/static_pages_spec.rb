require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'GET /' do
    it 'returns a successful response' do
      get root_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('LSA Art Survey')
    end
  end
end
