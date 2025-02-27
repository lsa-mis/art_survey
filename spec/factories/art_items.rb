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
FactoryBot.define do
  factory :art_item do
    location_building { Faker::Address.building_number }
    location_room { Faker::Address.secondary_address }
    value_cost { Faker::Number.between(from: 1000, to: 100000) }
    date_acquired { Faker::Date.backward(days: 365) }
    department_contact { Faker::Name.name }
    updated_by { 1 }
    archived { false }

    # Associations
    association :department
    association :appraisal_type

    # Add a rich text description
    after(:build) do |art_item|
      art_item.description = ActionText::Content.new(Faker::Lorem.paragraph(sentence_count: 3))
      art_item.appraisal_description = ActionText::Content.new(Faker::Lorem.paragraph(sentence_count: 2))
      art_item.protection = ActionText::Content.new(Faker::Lorem.paragraph(sentence_count: 2))
    end
  end
end
