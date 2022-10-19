# == Schema Information
#
# Table name: art_items
#
#  id                 :bigint           not null, primary key
#  location_building  :string           not null
#  location_room      :string           not null
#  value_cost         :integer          not null
#  date_acquired      :date
#  appraisal_type_id  :bigint           not null
#  department_id      :bigint           not null
#  updated_by         :integer
#  department_contact :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  archived           :boolean          default(FALSE)
#
class ArtItem < ApplicationRecord
  belongs_to :appraisal_type
  belongs_to :department
  has_many :annotations
  has_rich_text :description
  has_rich_text :appraisal_description
  has_rich_text :protection
  has_many_attached :documents
  has_many_attached :images
end
