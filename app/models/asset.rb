# == Schema Information
#
# Table name: assets
#
#  id                 :integer          not null, primary key
#  appraisal_type_id  :integer          not null
#  department_id      :integer          not null
#  updated_by         :string
#  location_building  :string
#  location_room      :string
#  value_cost         :integer
#  date_acquired      :datetime
#  department_contact :string
#  archived           :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Asset < ApplicationRecord
  belongs_to :appraisal_type
  belongs_to :department

  has_rich_text :description
  has_rich_text :appraisal_description
  has_rich_text :protection

  has_many_attached :support_documents
  has_many_attached :photos

end
