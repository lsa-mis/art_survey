# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  updated_by  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      role = build(:role)
      expect(role).to be_valid
    end

    it 'is not valid without a title' do
      role = build(:role, title: nil)
      expect(role).not_to be_valid
      expect(role.errors[:title]).to include("can't be blank")
    end

    it 'is not valid with a duplicate title' do
      create(:role, title: 'Admin')
      role = build(:role, title: 'Admin')
      expect(role).not_to be_valid
      expect(role.errors[:title]).to include("has already been taken")
    end
  end

  describe 'associations' do
    it 'has many permissions' do
      association = described_class.reflect_on_association(:permissions)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end
  end

  describe 'instance methods' do
    let(:role) { create(:role, title: 'Test Role') }

    it 'returns the title with show_role_title' do
      expect(role.show_role_title).to eq('Test Role')
    end
  end
end
