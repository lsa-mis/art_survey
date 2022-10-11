# == Schema Information
#
# Table name: art_items
#
#  id                 :bigint           not null, primary key
#  location_building  :string           not null
#  location_room      :string
#  value_cost         :integer
#  date_acquired      :date
#  appraisal_types_id :bigint
#  archived           :boolean          default(FALSE), not null
#  departments_id     :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint
#
class ArtItem < ApplicationRecord
  has_rich_text :description
  has_rich_text :appraisal_description
  has_rich_text :protection
  belongs_to :appraisal_types
  belongs_to :department
  belongs_to :user # updated_by user
end
