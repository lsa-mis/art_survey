# == Schema Information
#
# Table name: annotations
#
#  id         :integer          not null, primary key
#  uri        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  updated_by :string           not null
#
require 'rails_helper'

RSpec.describe Annotation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
