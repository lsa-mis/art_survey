FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    trait :admin do
      after(:create) do |user|
        user.add_role(:admin)
      end
    end
  end

  factory :role do
    name { 'user' }
  end

  factory :permission do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end

  factory :department do
    name { Faker::Company.department }
    description { Faker::Lorem.paragraph }
  end

  factory :art_item do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    department
    user
  end

  factory :appraisal_type do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end
end
