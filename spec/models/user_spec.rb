# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  uniqname               :string
#  principal_name         :string
#  display_name           :string
#  person_affiliation     :string
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  # Basic Object Creation
  describe 'factory' do
    it 'has a valid factory' do
      expect(user).to be_valid
    end
  end

  # Validation tests
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with an invalid email format' do
      user = build(:user, email: 'invalid-email')
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
    end

    describe 'email validations' do
      context 'when email is not present' do
        before { user.email = nil }

        it 'is not valid' do
          expect(user).not_to be_valid
          expect(user.errors[:email]).to include("can't be blank")
        end
      end

      context 'when email is already taken' do
        before do
          create(:user, email: 'test@example.com')
          user.email = 'test@example.com'
        end

        it 'is not valid' do
          expect(user).not_to be_valid
          expect(user.errors[:email]).to include('has already been taken')
        end
      end

      context 'when email format is invalid' do
        it 'is not valid with missing @ symbol' do
          user.email = 'userexample.com'
          expect(user).not_to be_valid
          expect(user.errors[:email]).to include('is invalid')
        end

        it 'is not valid with missing domain' do
          user.email = 'user@'
          expect(user).not_to be_valid
          expect(user.errors[:email]).to include('is invalid')
        end

        it 'is not valid with missing username' do
          user.email = '@example.com'
          expect(user).not_to be_valid
          expect(user.errors[:email]).to include('is invalid')
        end
      end
    end

    describe 'password validations' do
      context 'when creating a new user' do
        it 'requires a password' do
          user.password = nil
          expect(user).not_to be_valid
          expect(user.errors[:password]).to include("can't be blank")
        end

        it 'requires a minimum password length' do
          user.password = '12345'
          user.password_confirmation = '12345'
          expect(user).not_to be_valid
          expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
        end
      end
    end
  end

  # Devise Module Tests
  describe 'devise modules' do
    it 'includes database_authenticatable module' do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it 'includes registerable module' do
      expect(User.devise_modules).to include(:registerable)
    end

    it 'includes recoverable module' do
      expect(User.devise_modules).to include(:recoverable)
    end

    it 'includes rememberable module' do
      expect(User.devise_modules).to include(:rememberable)
    end

    it 'includes validatable module' do
      expect(User.devise_modules).to include(:validatable)
    end

    it 'includes trackable module' do
      expect(User.devise_modules).to include(:trackable)
    end

    it 'includes omniauthable module' do
      expect(User.devise_modules).to include(:omniauthable)
    end

    it 'configures saml as omniauth provider' do
      expect(User.omniauth_providers).to eq([:saml])
    end
  end

  # Method tests
  describe '#display_name_email' do
    context 'when display_name and email are present' do
      it 'returns the display name and email' do
        user.display_name = 'John Doe'
        user.email = 'john@example.com'
        expect(user.display_name_email).to eq('John Doe - john@example.com')
      end
    end

    context 'when display_name is nil' do
      it 'returns the email with a nil display name' do
        user.display_name = nil
        user.email = 'john@example.com'
        expect(user.display_name_email).to eq(' - john@example.com')
      end
    end
  end

  # Authentication tests
  describe 'authentication' do
    let(:password) { 'password123' }
    let(:user) { create(:user, password: password, password_confirmation: password) }

    it 'authenticates with correct password' do
      expect(user.valid_password?(password)).to be true
    end

    it 'does not authenticate with incorrect password' do
      expect(user.valid_password?('wrong_password')).to be false
    end
  end

  # Trackable tests
  describe 'trackable' do
    let(:user) { create(:user) }

    it 'updates sign in count on authentication' do
      expect { user.update(sign_in_count: user.sign_in_count + 1) }
        .to change(user, :sign_in_count).by(1)
    end

    it 'tracks last sign in timestamp' do
      timestamp = Time.current
      user.update(last_sign_in_at: timestamp)
      expect(user.last_sign_in_at).to be_within(1.second).of(timestamp)
    end
  end

  describe 'instance methods' do
    let(:user) { create(:user, display_name: 'Test User', email: 'test@example.com') }

    it 'returns the display name and email with display_name_email' do
      expect(user.display_name_email).to eq('Test User - test@example.com')
    end
  end
end
