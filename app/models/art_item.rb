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
  has_one :description, class_name: 'ActionText::RichText', as: :record
  has_rich_text :appraisal_description
  has_one :appraisal_description, class_name: 'ActionText::RichText', as: :record
  has_rich_text :protection
  has_one :protection, class_name: 'ActionText::RichText', as: :record
  has_many_attached :documents
  include AppendToHasManyAttached['documents']
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [640, 480]
  end
  include AppendToHasManyAttached['images']

  validates :department_id, :department_contact, :description, :location_building, :location_room, :date_acquired, :appraisal_type_id, presence: true
  validates :value_cost, numericality: { only_integer: true, greater_than_or_equal_to: 1000 }

  validate :has_description
  validate :acceptable_documents

  scope :active_with_departments, -> { ArtItem.with_attached_documents.includes(:department).where(archived: false) }
  scope :archived_with_departments, -> { ArtItem.includes(:department).where(archived: true) }

  def has_description
    unless description&.body&.present?
      errors.add(:description, "Can't be blank")
    end
  end

  def acceptable_documents
    return unless documents.attached?
  
    acceptable_types = [
      "application/pdf", "text/plain", "image/jpg", 
      "image/jpeg", "image/png", 
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    ]

    documents.each do |doc|
      unless doc.byte_size <= 20.megabyte
        errors.add(:documents, "is too big")
      end

      unless acceptable_types.include?(doc.content_type)
        errors.add(:documents, "must be an acceptable file type (pdf,txt,jpg,png,doc)")
      end
    end
  end

end
