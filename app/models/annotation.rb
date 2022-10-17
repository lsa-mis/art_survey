class Annotation < ApplicationRecord
  belongs_to :art_item
  has_rich_text :note
end
