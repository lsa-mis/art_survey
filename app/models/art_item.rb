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
  validate :validate_documents
  validate :validate_images

  scope :active_with_departments, -> { ArtItem.with_attached_documents.includes(:department).where(archived: false) }
  scope :archived_with_departments, -> { ArtItem.includes(:department).where(archived: true) }

  def has_description
    unless description&.body&.present?
      errors.add(:description, "Can't be blank")
    end
  end
 
  private

  def validate_documents
    documents.each do |document|
      if document.blob.content_type.start_with?('application/') # Check if it's a document
        if document.blob.byte_size > 10.megabytes # Adjust the size limit as needed
          errors.add(:documents, "Document size exceeds the 10MB limit.")
        end
      else
        errors.add(:documents, "Invalid file format. Only documents are allowed.")
      end
    end
  end

  def validate_images
    return unless images.attached?

    images.each do |image|
      if image.blob.content_type.start_with?('image/') # Check if it's an image
        if image.blob.byte_size > 5.megabytes # Adjust the size limit as needed
          errors.add(:images, "Image size exceeds the 5MB limit.")
        end
      else
        errors.add(:images, "Invalid file format. Only images are allowed.")
      end
    end
  end

end
