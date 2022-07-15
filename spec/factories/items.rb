# == Schema Information
#
# Table name: items
#
#  id                 :bigint           not null, primary key
#  description        :string
#  location_building  :string
#  location_room      :string
#  value_cost         :integer
#  date_acquired      :datetime
#  department_contact :string
#  updated_by         :string
#  archived           :boolean
#  appraisal_type_id  :bigint           not null
#  department_id      :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
FactoryBot.define do
  factory :item do
    description { "MyString" }
    location_building { "MyString" }
    location_room { "MyString" }
    value_cost { 1 }
    date_acquired { "2022-07-15 16:58:10" }
    department_contact { "MyString" }
    updated_by { "MyString" }
    archived { false }
    appraisal_type { nil }
    department { nil }
  end
end
