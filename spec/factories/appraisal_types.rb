# == Schema Information
#
# Table name: appraisal_types
#
#  id             :bigint           not null, primary key
#  classification :string
#  description    :text
#  updated_by     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :appraisal_type do
    classification { "MyString" }
    description { "MyText" }
    updated_by { 1 }
  end
end
