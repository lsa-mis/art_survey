# == Schema Information
#
# Table name: page_informations
#
#  id         :bigint           not null, primary key
#  location   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe PageInformation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
