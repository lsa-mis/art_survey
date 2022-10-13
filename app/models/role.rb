# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text
#  user_id     :bigint           # updated_by
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Role < ApplicationRecord
end
