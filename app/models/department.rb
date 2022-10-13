# == Schema Information
#
# Table name: departments
#
#  id          :bigint           not null, primary key
#  dept_number :integer          not null
#  name        :string           not null
#  short_name  :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
class Department < ApplicationRecord
  has_many :art_items
end
