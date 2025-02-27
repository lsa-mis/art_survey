# == Schema Information
#
# Table name: annotations
#
#  id          :bigint           not null, primary key
#  updated_by  :integer
#  art_item_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Annotation, type: :model do
  # Setup - create necessary test objects
  let(:art_item) { create(:art_item) }
  let(:valid_attributes) do
    {
      art_item: art_item,
      updated_by: 1,
      note: '<div>This is a test annotation</div>'
    }
  end

  # Association tests
  describe 'associations' do
    it 'belongs to an art_item' do
      association = Annotation.reflect_on_association(:art_item)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has rich text note' do
      # Test that the model responds to the note method
      annotation = Annotation.new
      expect(annotation).to respond_to(:note)
    end
  end

  # Validation tests
  describe 'validations' do
    it 'requires updated_by to be present' do
      annotation = Annotation.new(valid_attributes.merge(updated_by: nil))
      expect(annotation).not_to be_valid
      expect(annotation.errors[:updated_by]).to include("can't be blank")
    end

    it 'requires note to be present' do
      annotation = Annotation.new(valid_attributes.merge(note: nil))
      expect(annotation).not_to be_valid
      expect(annotation.errors[:note]).to include("can't be blank")
    end
  end

  # Factory tests
  describe 'factory' do
    it 'has a valid factory' do
      annotation = build(:annotation, art_item: art_item, note: '<div>Test note</div>')
      expect(annotation).to be_valid
    end
  end

  # Instance method tests
  describe 'instance methods' do
    it 'creates a valid annotation' do
      annotation = Annotation.new(valid_attributes)
      expect(annotation).to be_valid
    end

    it 'is invalid without a note' do
      annotation = Annotation.new(valid_attributes.merge(note: nil))
      expect(annotation).not_to be_valid
      expect(annotation.errors[:note]).to include("can't be blank")
    end

    it 'is invalid without an updated_by value' do
      annotation = Annotation.new(valid_attributes.merge(updated_by: nil))
      expect(annotation).not_to be_valid
      expect(annotation.errors[:updated_by]).to include("can't be blank")
    end

    it 'is invalid without an art_item' do
      annotation = Annotation.new(valid_attributes.merge(art_item: nil))
      expect(annotation).not_to be_valid
      expect(annotation.errors[:art_item]).to include("must exist")
    end
  end

  # Behavior tests
  describe 'behavior' do
    it 'associates with the correct art item' do
      annotation = Annotation.create(valid_attributes)
      expect(annotation.art_item).to eq(art_item)
    end

    it 'stores rich text content in the note field' do
      content = '<div>This is <strong>rich</strong> text content</div>'
      annotation = Annotation.create(valid_attributes.merge(note: content))
      expect(annotation.note.body.to_s).to include('This is <strong>rich</strong> text content')
    end
  end
end
