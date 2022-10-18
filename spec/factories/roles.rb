# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  updated_by  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :role do
    title { "MyString" }
    description { "MyText" }
    updated_by { 1 }
  end
end
