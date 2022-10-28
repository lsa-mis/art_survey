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
    description {Faker::Lorem.sentence(word_count: 3)}
    location_building {Faker::University.suffix}
    location_room {Faker::Number.number(digits: 4)}
    value_cost {Faker::Number.number(digits: 4)}
    date_acquired {Faker::Date.backward(days: 14)}
    association :appraisal_type
    appraisal_description {Faker::Lorem.paragraph}
    protection {Faker::Lorem.paragraph}
    archived { 0 }
    association :department
    updated_by { 1 }
    department_contact {Faker::Name.name}
    association :annotation
    documents { nil }
    images { nil }
  end
end
