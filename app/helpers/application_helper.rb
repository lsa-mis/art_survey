module ApplicationHelper

  def svg(svg)
    file_path = "app/assets/images/svg/#{svg}.svg"
    return File.read(file_path).html_safe if File.exist?(file_path)
    file_path
  end
  
  def content_message(location)
    PageInformation.find_by(location: location).content  if PageInformation.find_by(location: location).present?
  end

  def show_date(field)
    field.strftime("%m/%d/%Y") unless field.blank?
  end

end
