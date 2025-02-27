# == Schema Information
#
# Table name: page_informations
#
#  id         :bigint           not null, primary key
#  location   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :page_information do
    sequence(:location) { |n| "page_#{n}" }

    # Add rich text content
    after(:build) do |page_info|
      page_info.content = '<div>This is factory-generated content for the page</div>'
    end

    # Create variations for common pages
    trait :home do
      location { "home" }
      after(:build) do |page_info|
        page_info.content = '<div>Welcome to the home page</div>'
      end
    end

    trait :about do
      location { "about" }
      after(:build) do |page_info|
        page_info.content = '<div>About this application</div>'
      end
    end

    trait :contact do
      location { "contact" }
      after(:build) do |page_info|
        page_info.content = '<div>Contact information</div>'
      end
    end

    # Allow setting custom content
    transient do
      content_text { nil }
    end

    after(:build) do |page_info, evaluator|
      if evaluator.content_text.present?
        page_info.content = "<div>#{evaluator.content_text}</div>"
      end
    end
  end
end
