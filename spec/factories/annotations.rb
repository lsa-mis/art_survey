# == Schema Information
#
# Table name: annotations
#
#  id          :bigint           not null, primary key
#  updated_by  :integer
#  art_item_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :annotation do
    updated_by { 1 }
    art_item {1}
  end
end
