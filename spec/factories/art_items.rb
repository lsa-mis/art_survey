# == Schema Information
#
# Table name: art_items
#
#  id                 :bigint           not null, primary key
#  description        :string           not null
#  location_building  :string           not null
#  location_room      :string
#  value_cost         :integer
#  date_acquired      :date
#  appraisal_types_id :bigint
#  archived           :boolean          default(FALSE), not null
#  departments_id     :bigint
#  updated_by         :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
FactoryBot.define do
  factory :art_item do
    description { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
    location_building { Faker::Educator.university }
    location_room { Faker::Number.number(digits: 4) }
    value_cost { Faker::Number.number(digits: 6) }
    date_acquired { Faker::Date.backward(days: 365) }
    association :appraisal_type
    archived { false }
    association :departments
    updated_by nil
  end
end
