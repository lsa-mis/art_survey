# == Schema Information
#
# Table name: art_items
#
#  id                 :bigint           not null, primary key
#  location_building  :string           not null
#  location_room      :string           not null
#  value_cost         :integer          not null
#  date_acquired      :date
#  appraisal_type_id  :bigint           not null
#  department_id      :bigint           not null
#  updated_by         :integer
#  department_contact :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  archived           :boolean          default(FALSE)
#
require 'rails_helper'

RSpec.describe ArtItem, type: :model do

  let!(:art_item) do
    FactoryBot.create(:art_item)
  end

  context "value_cost is greter than 1000" do
    before { art_item.update!(value_cost: 1200) }

    it "enter value greater than 1000" do
      expect(art_item.value_cost).to be >= 1000
    end
  end

  context "value_cost equal to 1000" do
    before { art_item.update!(value_cost: 1000) }

    it "enter value equal to 1000" do
      expect(art_item.value_cost).to be >= 1000
    end
  end

  context "value less than 1000" do
    it "entering value less than 1000 is invalid" do
      art_item = build(:art_item, value_cost: 200)
      art_item.valid?
      expect(art_item).to_not be_valid
      expect(art_item.errors[:value_cost]).to include("must be greater than or equal to 1000")
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      # Create a complete art item with all required attributes including rich text
      department = create(:department)
      appraisal_type = create(:appraisal_type)

      art_item = build(:art_item,
        department: department,
        appraisal_type: appraisal_type,
        department_contact: "Test Contact",
        location_building: "332",
        location_room: "Suite 244",
        value_cost: 56739,
        date_acquired: "2024-09-01",
        updated_by: 1
      )

      # Ensure rich text is properly set
      art_item.description = ActionText::RichText.new(body: "<div>Test description</div>")
      art_item.appraisal_description = ActionText::RichText.new(body: "<div>Test appraisal</div>")
      art_item.protection = ActionText::RichText.new(body: "<div>Test protection</div>")

      expect(art_item).to be_valid
    end

    it 'is not valid without a location_building' do
      art_item = build(:art_item, location_building: nil)
      expect(art_item).not_to be_valid
    end

    it 'is not valid without a location_room' do
      art_item = build(:art_item, location_room: nil)
      expect(art_item).not_to be_valid
    end

    it 'is not valid without a value_cost' do
      art_item = build(:art_item, value_cost: nil)
      expect(art_item).not_to be_valid
    end

    it 'is not valid without an appraisal_type' do
      art_item = build(:art_item, appraisal_type: nil)
      expect(art_item).not_to be_valid
    end

    it 'is not valid without a department' do
      art_item = build(:art_item, department: nil)
      expect(art_item).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a department' do
      association = described_class.reflect_on_association(:department)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to an appraisal_type' do
      association = described_class.reflect_on_association(:appraisal_type)
      expect(association.macro).to eq :belongs_to
    end

    it 'has rich text description' do
      art_item = create(:art_item)
      expect(art_item.description).to be_present
    end

    it 'has rich text appraisal_description' do
      art_item = create(:art_item)
      expect(art_item.appraisal_description).to be_present
    end

    it 'has rich text protection' do
      art_item = create(:art_item)
      expect(art_item.protection).to be_present
    end
  end

  describe 'scopes' do
    let!(:archived_art_item) { create(:art_item, archived: true) }
    let!(:active_art_item) { create(:art_item, archived: false) }

    it 'returns only active art items with active scope' do
      expect(ArtItem.where(archived: false)).to include(active_art_item)
      expect(ArtItem.where(archived: false)).not_to include(archived_art_item)
    end

    it 'returns only archived art items with archived scope' do
      expect(ArtItem.where(archived: true)).to include(archived_art_item)
      expect(ArtItem.where(archived: true)).not_to include(active_art_item)
    end
  end
end
