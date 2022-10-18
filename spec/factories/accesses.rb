# == Schema Information
#
# Table name: accesses
#
#  id            :bigint           not null, primary key
#  permission_id :bigint           not null
#  uniqname      :string
#  updated_by    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :access do
    permission { nil }
    uniqname { "MyString" }
    updated_by { 1 }
  end
end
