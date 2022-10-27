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

  context "value cost is 1000" do
    before { phone_number.update!(value: "1000") }

    it "equals 1000" do
      expect(phone_number.value).to eq("5558568075")
    end
  end

  context "phone number contains parentheses" do
    before { phone_number.update!(value: "(555) 856-8075") }

    it "strips out the non-numeric characters" do
      expect(phone_number.value).to eq("5558568075")
    end
  end

  context "phone number contains country code" do
    before { phone_number.update!(value: "+1 555 856 8075") }

    it "strips out the country code" do
      expect(phone_number.value).to eq("5558568075")
    end
  end
end
