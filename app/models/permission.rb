# == Schema Information
#
# Table name: permissions
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  department_id :integer          not null
#  uniqname      :string           not null
#  role          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Permission < ApplicationRecord
  belongs_to :user
  belongs_to :department
end
