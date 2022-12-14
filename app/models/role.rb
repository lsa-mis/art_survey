# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  updated_by  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Role < ApplicationRecord
  has_many :permissions, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  def show_role_title
    self.title
  end
end
