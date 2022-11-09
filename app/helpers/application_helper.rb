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

  def show_user(id)
    User.find(id).updated_by_name
  end

  def render_flash_stream
    turbo_stream.update "flash", partial: "layouts/flash"
  end

  def show_department_fullname(id)
    Department.find(id).display_fullname
  end

  def show_role_title(id)
    Role.find(id).show_role_title
  end

end
