# == Schema Information
#
# Table name: assets
#
#  id                 :integer          not null, primary key
#  appraisal_type_id  :integer          not null
#  department_id      :integer          not null
#  updated_by         :string
#  location_building  :string
#  location_room      :string
#  value_cost         :integer
#  date_acquired      :datetime
#  department_contact :string
#  archived           :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe Asset, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
