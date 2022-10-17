class Permission < ApplicationRecord
  belongs_to :role
  belongs_to :department
  has_many :accesses
end
