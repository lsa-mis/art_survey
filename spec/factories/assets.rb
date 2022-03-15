# == Schema Information
#
# Table name: assets
#
#  id                 :integer          not null, primary key
#  appraisal_type_id  :integer          not null
#  department_id      :integer          not null
#  updated_by         :string
#  location_building  :string
#  location_room      :string
#  value_cost         :integer
#  date_acquired      :datetime
#  department_contact :string
#  archived           :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
FactoryBot.define do
  factory :asset do
    appraisal_type { nil }
    department { nil }
    updated_by { "MyString" }
    location_building { "MyString" }
    location_room { "MyString" }
    value_cost { 1 }
    date_acquired { "2022-03-15 16:37:26" }
    archived { false }
    department_contact { "MyString" }
  end
end
