FactoryBot.define do
  factory :annotation do
    note { nil }
    created_by { 1 }
    art_item { nil }
  end
end
