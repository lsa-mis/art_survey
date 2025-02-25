# == Schema Information
#
# Table name: accesses
#
#  id            :bigint           not null, primary key
#  permission_id :bigint           not null
#  uniqname      :string
#  updated_by    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Access, type: :model do
  # Setup
  let(:department) { create(:department) }
  let(:role) { create(:role) }
  let(:permission) { create(:permission, department: department, role: role) }
  let(:access) { build(:access, permission: permission) }

  # Validations
  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(access).to be_valid
    end

    it 'is not valid without a uniqname' do
      access.uniqname = nil
      expect(access).not_to be_valid
      expect(access.errors[:uniqname]).to include("can't be blank")
    end

    it 'is not valid without an updated_by' do
      access.updated_by = nil
      expect(access).not_to be_valid
      expect(access.errors[:updated_by]).to include("can't be blank")
    end

    it 'is not valid without a permission_id' do
      access.permission_id = nil
      expect(access).not_to be_valid
      expect(access.errors[:permission_id]).to include("can't be blank")
    end

    it 'enforces uniqueness of permission_id scoped to uniqname' do
      access.save
      duplicate_access = build(:access,
                              permission: permission,
                              uniqname: access.uniqname)
      expect(duplicate_access).not_to be_valid
      expect(duplicate_access.errors[:permission_id]).to include('has already been taken')
    end

    it 'allows the same uniqname with different permissions' do
      access.save
      other_permission = create(:permission,
                               department: create(:department),
                               role: create(:role))
      new_access = build(:access,
                        permission: other_permission,
                        uniqname: access.uniqname)
      expect(new_access).to be_valid
    end
  end

  # Associations
  describe 'associations' do
    it 'belongs to a permission' do
      expect(access).to respond_to(:permission)
      expect(access.permission).to eq(permission)
    end

    it 'can access the associated role through permission' do
      expect(access.permission.role).to eq(role)
    end

    it 'can access the associated department through permission' do
      expect(access.permission.department).to eq(department)
    end
  end

  # Database constraints
  describe 'database constraints' do
    it 'has a foreign key constraint on permission_id' do
      access.save
      expect {
        access.update_column(:permission_id, -1)
      }.to raise_error(ActiveRecord::InvalidForeignKey)
    end
  end

  # Factory
  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:access, permission: permission)).to be_valid
    end
  end

  # Lifecycle
  describe 'lifecycle' do
    it 'can be created with valid attributes' do
      expect {
        create(:access, permission: permission)
      }.to change(Access, :count).by(1)
    end

    it 'can be updated with valid attributes' do
      access.save
      new_uniqname = 'new_uniqname'
      expect {
        access.update(uniqname: new_uniqname)
      }.to change { access.reload.uniqname }.to(new_uniqname)
    end

    it 'can be destroyed' do
      access.save
      expect {
        access.destroy
      }.to change(Access, :count).by(-1)
    end
  end
end
