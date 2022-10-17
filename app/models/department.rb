class Department < ApplicationRecord
  has_many :art_items
  has_many :permissions
end
