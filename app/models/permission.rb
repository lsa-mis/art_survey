# == Schema Information
#
# Table name: permissions
#
#  id            :bigint           not null, primary key
#  role_id       :bigint           not null
#  department_id :bigint           not null
#  updated_by    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Permission < ApplicationRecord
  
  belongs_to :role
  belongs_to :department
  has_many :accesses

  around_save :set_updated_by

  def set_updated_by
    self.updated_by = current_user
  end
end
