# == Schema Information
#
# Table name: annotations
#
#  id         :bigint           not null, primary key
#  uri        :string
#  updated_by :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Annotation < ApplicationRecord
	has_rich_text :note
end
