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
require 'rails_helper'

RSpec.describe Department, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
