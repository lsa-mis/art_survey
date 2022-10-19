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
    deptID { 1 }
    fullname { "MyString" }
    shortname { "MyString" }
    updated_by { 1 }
  end
end
