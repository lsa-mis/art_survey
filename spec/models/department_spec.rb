# == Schema Information
#
# Table name: departments
#
#  id          :integer          not null, primary key
#  dept_number :integer          not null
#  name        :string           not null
#  short_name  :string
#  updated_by  :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Department, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
