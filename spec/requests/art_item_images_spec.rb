require 'rails_helper'

RSpec.describe 'ArtItemImages', type: :request do
  let(:user) { create(:user) }
  let(:art_item) { create(:art_item) }
  let(:role) { create(:role, title: 'SuperUser') }
  let(:permission) { create(:permission, role: role, department: art_item.department) }
  let!(:access) { create(:access, permission: permission, uniqname: user.uniqname) }

  before do
    sign_in user
    allow_any_instance_of(ApplicationController).to receive(:session).and_return({ user_uniqname: user.uniqname })
  end

  describe 'GET /art_items/:art_item_id/art_item_images' do
    it 'returns a successful response for an authorized user' do
      get art_item_art_item_images_path(art_item)

      expect(response).to have_http_status(:ok)
    end

    it 'redirects unauthorized users' do
      access.destroy

      get art_item_art_item_images_path(art_item)

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Not Authorized.')
    end
  end
end
