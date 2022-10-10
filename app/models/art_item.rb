# == Schema Information
#
# Table name: art_items
#
#  id                 :bigint           not null, primary key
#  description        :string           not null
#  location_building  :string           not null
#  location_room      :string
#  value_cost         :integer
#  date_acquired      :date
#  appraisal_types_id :bigint
#  archived           :boolean          default(FALSE), not null
#  departments_id     :bigint
#  updated_by         :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class ArtItem < ApplicationRecord
  has_rich_text :appraisal_description
	has_rich_text :protection
	belongs_to :department
end
