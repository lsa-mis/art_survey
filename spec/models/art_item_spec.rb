# == Schema Information
#
# Table name: art_items
#
#  id                 :bigint           not null, primary key
#  description        :string           not null
#  location_building  :string           not null
#  location_room      :string
#  value_cost         :integer
#  date_acquired      :date
#  appraisal_types_id :bigint
#  archived           :boolean          default(FALSE), not null
#  departments_id     :bigint
#  updated_by         :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require 'rails_helper'

RSpec.describe ArtItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
