FactoryBot.define do
  factory :permission do
    uniqname { "MyString" }
    role { nil }
    department { nil }
    updated_by { 1 }
  end
end
