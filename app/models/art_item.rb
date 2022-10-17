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
