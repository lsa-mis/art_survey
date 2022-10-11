# == Schema Information
#
# Table name: departments
#
#  id          :bigint           not null, primary key
#  dept_number :integer          not null
#  name        :string           not null
#  short_name  :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
FactoryBot.define do
  factory :department do
    dept_number { Faker::Number.number(digits: 6) }
    name { Faker::Commerce.department }
    short_name { Faker::Alphanumeric.alpha(number: 4) }
    association :user
  end
end
