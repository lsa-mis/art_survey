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
require 'rails_helper'

RSpec.describe Permission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
