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
