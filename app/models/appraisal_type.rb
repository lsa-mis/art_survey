# == Schema Information
#
# Table name: appraisal_types
#
#  id             :bigint           not null, primary key
#  classification :string
#  description    :text
#  updated_by     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class AppraisalType < ApplicationRecord
  has_many :art_items
end
