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

  # Optimized scopes for better performance

  # Basic scope - minimal eager loading for better performance
  scope :active_with_departments, -> {
    includes(:department, :appraisal_type)
    .where(archived: false)
  }

  # Full scope for archived items that need all associations
  scope :archived_with_departments, -> {
    includes(:department, :appraisal_type)
    .with_attached_documents
    .with_attached_images
    .with_rich_text_description
    .with_rich_text_appraisal_description
    .with_rich_text_protection
    .where(archived: true)
  }

  # More specific scope for detailed view with all associations
  scope :with_all_associations, -> {
    includes(:department, :appraisal_type, :annotations)
    .with_attached_documents
    .with_attached_images
    .with_rich_text_description
    .with_rich_text_appraisal_description
    .with_rich_text_protection
  }

  # Lightweight scope for index pages and listings
  scope :for_listing, -> {
    includes(:department)
    .with_attached_images
    .with_rich_text_description
    .where(archived: false)
  }

  # Batch preload associations for collections
  def self.batch_load_for_listing(items)
    ActiveRecord::Associations::Preloader.new(
      records: items,
      associations: [
        :department,
        { images_attachments: :blob },
        :rich_text_description
      ]
    ).call
    items
  end

  def has_description
    unless description&.body&.present?
      errors.add(:description, "Can't be blank")
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["appraisal_type_id", "archived", "created_at", "date_acquired",
     "department_contact", "department_id", "id", "location_building",
     "location_room", "updated_at", "updated_by", "value_cost"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["appraisal_type", "department", "annotations", "rich_text_description",
     "rich_text_appraisal_description", "rich_text_protection"]
  end

  private

  def validate_documents
    return unless documents.attached?

    acceptable_doc_types = ['application/pdf', 'application/msword',
                          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                          'text/plain', 'application/rtf', 'application/vnd.ms-excel',
                          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet']

    documents.each do |document|
      if document.content_type.in?(acceptable_doc_types)
        if document.blob.byte_size > 5.megabytes # Adjust the size limit as needed
          errors.add(:documents, "Document size exceeds the 5MB limit.")
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
