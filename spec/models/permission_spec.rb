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
require 'rails_helper'

RSpec.describe Permission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
