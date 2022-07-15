# == Schema Information
#
# Table name: permissions
#
#  id            :bigint           not null, primary key
#  user_id       :bigint           not null
#  department_id :bigint           not null
#  uniqname      :string           not null
#  role          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :permission do
    user { nil }
    department { nil }
    uniqname { "MyString" }
    role { "MyString" }
  end
end
