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
require 'rails_helper'

RSpec.describe Permission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
