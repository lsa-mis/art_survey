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
    deptID { Faker::Number.number(digits: 6 )}
    fullname { Faker::Commerce.department }
    shortname { Faker::Alphanumeric.alpha(number: 3).upcase }
    updated_by { 1 }
  end
end
