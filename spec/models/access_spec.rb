# == Schema Information
#
# Table name: accesses
#
#  id            :bigint           not null, primary key
#  permission_id :bigint           not null
#  uniqname      :string
#  updated_by    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Access, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
