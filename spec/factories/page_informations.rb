# == Schema Information
#
# Table name: page_informations
#
#  id         :bigint           not null, primary key
#  location   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :page_information do
    location { "home" }
  end
end
