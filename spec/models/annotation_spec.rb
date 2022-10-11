# == Schema Information
#
# Table name: annotations
#
#  id         :bigint           not null, primary key
#  uri        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
require 'rails_helper'

RSpec.describe Annotation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
