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
class Annotation < ApplicationRecord
  has_rich_text :note
end
