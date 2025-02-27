# == Schema Information
#
# Table name: permissions
#
#  id            :bigint           not null, primary key
#  role_id       :bigint           not null
#  department_id :bigint           not null
#  updated_by    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Permission, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      role = create(:role)
      department = create(:department)
      permission = build(:permission, role: role, department: department)
      expect(permission).to be_valid
    end

    it 'is not valid without a department_id' do
      permission = build(:permission, department_id: nil)
      expect(permission).not_to be_valid
      expect(permission.errors[:department_id]).to include("can't be blank")
    end

    it 'is not valid without a role_id' do
      permission = build(:permission, role_id: nil)
      expect(permission).not_to be_valid
      expect(permission.errors[:role_id]).to include("can't be blank")
    end

    it 'is not valid with a duplicate role_id for the same department_id' do
      department = create(:department)
      role = create(:role)
      create(:permission, department: department, role: role)

      permission = build(:permission, department: department, role: role)
      expect(permission).not_to be_valid
      expect(permission.errors[:role_id]).to include("has already been taken")
    end
  end

  describe 'associations' do
    it 'belongs to a role' do
      association = described_class.reflect_on_association(:role)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a department' do
      association = described_class.reflect_on_association(:department)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many accesses' do
      association = described_class.reflect_on_association(:accesses)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end
  end

  describe 'instance methods' do
    let(:department) { create(:department, fullname: 'Test Department') }
    let(:role) { create(:role, title: 'Test Role') }
    let(:permission) { create(:permission, department: department, role: role) }

    it 'returns the department name and role title with department_name_and_role_title' do
      expect(permission.department_name_and_role_title).to eq('Test Department - Test Role')
    end

    it 'returns the department full name with department_full_name' do
      expect(permission.department_full_name).to eq('Test Department')
    end
  end
end
