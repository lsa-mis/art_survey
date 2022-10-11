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
class Annotation < ApplicationRecord
  has_rich_text :note
  belongs_to :user # updated_by user
end
