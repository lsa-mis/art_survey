# == Schema Information
#
# Table name: appraisal_types
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
require 'rails_helper'

RSpec.describe AppraisalType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
