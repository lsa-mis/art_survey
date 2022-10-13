# == Schema Information
#
# Table name: permissions
#
#  id             :bigint           not null, primary key
#  uniqname       :string           not null
#  role           :string           not null
#  departments_id :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
class Permission < ApplicationRecord
end
