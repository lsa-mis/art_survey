# == Schema Information
#
# Table name: appraisal_types
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
FactoryBot.define do
  factory :appraisal_type do

  end
end
