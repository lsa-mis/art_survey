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

  # Validation tests
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  # Method tests
  describe '#display_name_email' do
    it 'returns the display name and email' do
      user.display_name = 'John Doe'
      user.email = 'john@example.com'
      expect(user.display_name_email).to eq('John Doe - john@example.com')
    end
  end
end
