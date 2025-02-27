# == Schema Information
#
# Table name: departments
#
#  id         :bigint           not null, primary key
#  deptID     :integer          not null
#  fullname   :string           not null
#  shortname  :string
#  updated_by :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :department do
    sequence(:deptID) { |n| 100000 + n }
    fullname { Faker::University.name }
    shortname { Faker::University.greek_organization }
    updated_by { 1 }
  end
end
