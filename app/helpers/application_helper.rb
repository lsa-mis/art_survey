module ApplicationHelper

  def content_message(location)
    PageInformation.find_by(location: location).content  if PageInformation.find_by(location: location).present?
  end

end
