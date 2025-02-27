# == Schema Information
#
# Table name: annotations
#
#  id          :bigint           not null, primary key
#  updated_by  :integer
#  art_item_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :annotation do
    updated_by { 1 }
    association :art_item

    # Add rich text note
    after(:build) do |annotation|
      annotation.note = '<div>This is a factory-generated annotation note</div>'
    end

    # Create a variation with a longer note
    trait :detailed do
      after(:build) do |annotation|
        annotation.note = '<div>This is a detailed annotation with <strong>formatted</strong> content that provides more information about the art item.</div>'
      end
    end

    # Allow setting a custom note
    transient do
      note_content { nil }
    end

    after(:build) do |annotation, evaluator|
      if evaluator.note_content.present?
        annotation.note = "<div>#{evaluator.note_content}</div>"
      end
    end
  end
end
