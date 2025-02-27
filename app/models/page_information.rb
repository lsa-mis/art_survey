# == Schema Information
#
# Table name: page_informations
#
#  id         :bigint           not null, primary key
#  location   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PageInformation < ApplicationRecord
  has_rich_text :content

  after_save :clear_cache

  private

  def clear_cache
    Rails.cache.delete("page_information/#{location}")
  end
end
