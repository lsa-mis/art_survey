# == Schema Information
#
# Table name: art_items
#
#  id                 :bigint           not null, primary key
#  location_building  :string           not null
#  location_room      :string
#  value_cost         :integer
#  date_acquired      :date
#  appraisal_types_id :bigint
#  archived           :boolean          default(FALSE), not null
#  departments_id     :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint
#
FactoryBot.define do
  factory :art_item do
    location_building { Faker::Educator.university }
    location_room { Faker::Number.number(digits: 4) }
    value_cost { Faker::Number.number(digits: 6) }
    date_acquired { Faker::Date.backward(days: 365) }
    association :appraisal_type
    archived { false }
    association :departments
    association :user
  end
end
