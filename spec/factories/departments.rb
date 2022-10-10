# == Schema Information
#
# Table name: departments
#
#  id          :bigint           not null, primary key
#  dept_number :integer          not null
#  name        :string           not null
#  short_name  :string           not null
#  updated_by  :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :department do
    
  end
end
