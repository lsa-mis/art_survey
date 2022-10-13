# == Schema Information
#
# Table name: annotations
#
#  id          :bigint           not null, primary key
#  uri         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#  art_item_id :bigint
#
FactoryBot.define do
  factory :annotation do

  end
end
