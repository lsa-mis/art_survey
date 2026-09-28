# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  def auth_hash(email:, uid: 'saml-uid', name: 'Art User', affiliation: 'staff')
    OmniAuth::AuthHash.new(
      provider: 'saml',
      uid: uid,
      info: OmniAuth::AuthHash::InfoHash.new(
        email: email,
        uid: uid,
        principal_name: email,
        name: name,
        person_affiliation: affiliation
      )
    )
  end

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    $baseURL = '/'
  end

  describe '#get_uniqname' do
    it 'returns the local part of the email address' do
      expect(controller.send(:get_uniqname, 'jdoe@umich.edu')).to eq('jdoe')
    end

    it 'preserves dots and plus signs in the local part' do
      expect(controller.send(:get_uniqname, 'jane.doe+art@umich.edu')).to eq('jane.doe+art')
    end
  end

  describe '#set_user' do
    it 'finds an existing user by email and stores session uniqname/email' do
      user = create(:user, email: 'existing@umich.edu', uniqname: 'existing')
      request.env['omniauth.auth'] = auth_hash(email: 'existing@umich.edu')
      allow(controller).to receive(:user_signed_in?).and_return(false)

      expect { controller.send(:set_user) }.not_to change(User, :count)

      expect(controller.user).to eq(user)
      expect(session[:user_email]).to eq('existing@umich.edu')
      expect(session[:user_uniqname]).to eq('existing')
    end

    it 'creates a user from SAML attributes when no matching email exists' do
      request.env['omniauth.auth'] = auth_hash(
        email: 'brandnew@umich.edu',
        uid: 'brand-uid',
        name: 'Brand New',
        affiliation: 'faculty'
      )
      allow(controller).to receive(:user_signed_in?).and_return(false)

      expect { controller.send(:set_user) }.to change(User, :count).by(1)

      user = User.find_by!(email: 'brandnew@umich.edu')
      expect(user.uniqname).to eq('brandnew')
      expect(user.uid).to eq('brand-uid')
      expect(user.display_name).to eq('Brand New')
      expect(user.principal_name).to eq('brandnew@umich.edu')
      expect(user.person_affiliation).to eq('faculty')
      expect(session[:user_email]).to eq('brandnew@umich.edu')
      expect(session[:user_uniqname]).to eq('brandnew')
    end

    it 'uses the signed-in current_user and still refreshes session keys' do
      current = create(:user, email: 'signedin@umich.edu', uniqname: 'signedin')
      request.env['omniauth.auth'] = auth_hash(email: 'other@umich.edu')
      allow(controller).to receive(:user_signed_in?).and_return(true)
      allow(controller).to receive(:current_user).and_return(current)

      expect { controller.send(:set_user) }.not_to change(User, :count)

      expect(controller.user).to eq(current)
      expect(session[:user_email]).to eq('signedin@umich.edu')
      expect(session[:user_uniqname]).to eq('signedin')
    end
  end

  describe '#create_user' do
    it 'persists SAML profile fields and a generated password' do
      request.env['omniauth.auth'] = auth_hash(
        email: 'createonly@umich.edu',
        uid: 'create-uid',
        name: 'Create Only',
        affiliation: 'staff'
      )

      user = controller.send(:create_user)

      expect(user).to be_persisted
      expect(user.email).to eq('createonly@umich.edu')
      expect(user.uniqname).to eq('createonly')
      expect(user.uid).to eq('create-uid')
      expect(user.encrypted_password).to be_present
    end
  end

  describe 'POST #saml' do
    before do
      OmniAuth.config.test_mode = true
    end

    after do
      OmniAuth.config.mock_auth[:saml] = nil
      OmniAuth.config.test_mode = false
    end

    it 'signs in a newly created user and sets authorization session keys' do
      request.env['omniauth.auth'] = auth_hash(email: 'callback@umich.edu', uid: 'cb-uid', name: 'Callback User')

      post :saml

      user = User.find_by!(email: 'callback@umich.edu')
      expect(controller.current_user).to eq(user)
      expect(session[:user_uniqname]).to eq('callback')
      expect(session[:user_email]).to eq('callback@umich.edu')
      expect(response).to be_redirect
    end

    it 'signs in an existing user matched by email without creating a duplicate' do
      existing = create(:user, email: 'known@umich.edu', uniqname: 'known')
      request.env['omniauth.auth'] = auth_hash(email: 'known@umich.edu', uid: 'ignored-uid')

      expect { post :saml }.not_to change(User, :count)

      expect(controller.current_user).to eq(existing)
      expect(session[:user_uniqname]).to eq('known')
      expect(response).to be_redirect
    end
  end
end
