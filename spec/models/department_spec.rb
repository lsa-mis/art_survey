# == Schema Information
#
# Table name: departments
#
#  id         :bigint           not null, primary key
#  deptID     :integer          not null
#  fullname   :string           not null
#  shortname  :string
#  updated_by :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      department = build(:department)
      expect(department).to be_valid
    end

    it 'is not valid without a deptID' do
      department = build(:department, deptID: nil)
      expect(department).not_to be_valid
      expect(department.errors[:deptID]).to include("can't be blank")
    end

    it 'is not valid with a duplicate deptID' do
      create(:department, deptID: 12345)
      department = build(:department, deptID: 12345)
      expect(department).not_to be_valid
      expect(department.errors[:deptID]).to include("has already been taken")
    end

    it 'allows nil fullname at the model level' do
      department = build(:department, fullname: nil)
      expect(department).to be_valid
    end
  end

  describe 'associations' do
    it 'has many art_items' do
      association = described_class.reflect_on_association(:art_items)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    it 'has many permissions' do
      association = described_class.reflect_on_association(:permissions)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end
  end

  describe 'instance methods' do
    let(:department) { create(:department, fullname: 'Test Department', shortname: 'TD') }

    it 'returns the fullname with display_fullname' do
      expect(department.display_fullname).to eq('Test Department')
    end

    it 'returns the shortname with display_shortname' do
      expect(department.display_shortname).to eq('TD')
    end
  end
end
