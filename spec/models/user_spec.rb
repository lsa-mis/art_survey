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

  # Association tests
  describe 'associations' do
    it { should have_many(:art_items).dependent(:destroy) }
    it { should have_and_belong_to_many(:roles) }
  end

  # Validation tests
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  # Method tests
  describe '#full_name' do
    it 'returns the full name of the user' do
      user.first_name = 'John'
      user.last_name = 'Doe'
      expect(user.full_name).to eq('John Doe')
    end
  end

  # Role tests
  describe 'roles' do
    let(:admin_role) { create(:role, name: 'admin') }

    it 'can be assigned a role' do
      user.save
      user.roles << admin_role
      expect(user.roles).to include(admin_role)
    end

    it 'can check if it has a role' do
      user.save
      user.roles << admin_role
      expect(user.has_role?(:admin)).to be true
    end
  end
end
