# == Schema Information
#
# Table name: permissions
#
#  id            :bigint           not null, primary key
#  role_id       :bigint           not null
#  department_id :bigint           not null
#  updated_by    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :permission do
    uniqname { "MyString" }
    role { nil }
    department { nil }
    updated_by { 1 }
  end
end
