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

  validates :department_id, presence: true    
  validates :role_id, presence: true, uniqueness: { scope: :department_id }
end
