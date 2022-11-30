# == Schema Information
#
# Table name: departments
#
#  id         :bigint           not null, primary key
#  deptID     :integer          not null
#  fullname   :string           not null
#  shortname  :string
#  updated_by :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Department < ApplicationRecord
  has_many :art_items
  has_many :permissions

  validates :deptID, presence: true, uniqueness: true

  def display_fullname
    self.fullname
  end
end
