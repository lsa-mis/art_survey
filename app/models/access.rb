# == Schema Information
#
# Table name: accesses
#
#  id            :bigint           not null, primary key
#  permission_id :bigint           not null
#  uniqname      :string
#  updated_by    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Access < ApplicationRecord
  belongs_to :permission

  validates :uniqname, presence: true
  validates :updated_by, presence: true
  validates :permission_id, presence: true, uniqueness: { scope: :uniqname }
end
