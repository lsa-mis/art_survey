# == Schema Information
#
# Table name: permissions
#
#  id             :bigint           not null, primary key
#  uniqname       :string           not null
#  role           :string           not null
#  updated_by     :string           not null
#  departments_id :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :permission do
    
  end
end
