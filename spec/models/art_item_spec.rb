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

  # let!(:art_item) do
  #   FactoryBot.create(:art_item)
  # end

  context "value_cost can not be less than 1000" do
    # before { art_item.update!(value_cost: 1200) }

    it "enter value greater than 1000" do
      art_item = FactoryBot.create(:art_item)
      expect(art_item.value_cost).to be >= 1000
    end
  end

  # context "value greater than or equal to 1000" do
  #   before { art_item.update!(value_cost: 2300) }

  #   it "greater than or equal to 1000" do
  #     expect(art_item.value_cost).to be >= 1000
  #   end
  # end

  # context "value cannot be less than 1000" do
  #   before { art_item.update!(value_cost: 200) }

  #   it "less than 1000" do
  #     expect(art_item.value_cost).not_to be < 1000
  #   end
  # end
end
