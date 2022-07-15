# == Schema Information
#
# Table name: items
#
#  id                 :bigint           not null, primary key
#  description        :string
#  location_building  :string
#  location_room      :string
#  value_cost         :integer
#  date_acquired      :datetime
#  department_contact :string
#  updated_by         :string
#  archived           :boolean
#  appraisal_type_id  :bigint           not null
#  department_id      :bigint           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
