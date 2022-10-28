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
end
