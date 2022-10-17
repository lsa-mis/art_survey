FactoryBot.define do
  factory :access do
    permission { nil }
    uniqname { "MyString" }
    updated_by { 1 }
  end
end
