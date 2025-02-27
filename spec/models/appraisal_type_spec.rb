# == Schema Information
#
# Table name: appraisal_types
#
#  id             :bigint           not null, primary key
#  classification :string
#  description    :text
#  updated_by     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe AppraisalType, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      appraisal_type = build(:appraisal_type)
      expect(appraisal_type).to be_valid
    end

    it 'is valid without a classification' do
      # Assuming classification is optional based on the factory
      appraisal_type = build(:appraisal_type, classification: nil)
      expect(appraisal_type).to be_valid
    end

    it 'is valid without a description' do
      # Assuming description is optional based on the factory
      appraisal_type = build(:appraisal_type, description: nil)
      expect(appraisal_type).to be_valid
    end
  end

  describe 'associations' do
    it 'has many art_items' do
      association = described_class.reflect_on_association(:art_items)
      expect(association.macro).to eq :has_many
    end
  end
end
