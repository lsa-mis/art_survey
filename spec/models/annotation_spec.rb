# == Schema Information
#
# Table name: annotations
#
#  id          :bigint           not null, primary key
#  created_by  :integer
#  art_item_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Annotation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
