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
    description { nil }
    location_building { "MyString" }
    location_room { "MyString" }
    value_cost { 1 }
    date_acquired { "2022-10-17" }
    appraisal_type { nil }
    appraisal_description { nil }
    protection { nil }
    archived { "" }
    department { nil }
    updated_by { 1 }
    department_contact { "MyString" }
    annotation { nil }
    documents { nil }
    images { nil }
  end
end
