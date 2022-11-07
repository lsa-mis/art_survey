# == Schema Information
#
# Table name: annotations
#
#  id          :bigint           not null, primary key
#  created_by  :integer
#  art_item_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Annotation < ApplicationRecord
  belongs_to :art_item
  has_rich_text :note

  validates_presence_of :note
  validates :created_by, presence: true

end
