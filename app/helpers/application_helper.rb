module ApplicationHelper

  def svg(svg)
    file_path = "app/assets/images/svg/#{svg}.svg"
    return File.read(file_path).html_safe if File.exist?(file_path)
    file_path
  end

  def show_svg(type)
    case type
    when "text/plain"
      svg("text-1473")
    when "application/pdf"
      svg("pdf-3375")
    when "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      svg("office-1466")
    when "image/jpg" || "image/jpeg" || "image/png"
      svg("jpg-1476")
    else
      svg("attachment-1483")
    end
  end

  def content_message(location)
    Rails.cache.fetch("page_information/#{location}", expires_in: 12.hours) do
      page_info = PageInformation.find_by(location: location)
      page_info&.content
    end
  end

  def show_date(field)
    field.strftime("%m/%d/%Y") unless field.blank?
  end

  def show_user_name_by_id(id)
    User.find(id).display_name_email
  end

  def show_user_name_by_uniqname(uniqname)
    User.find_by(uniqname: uniqname).present? ? "#{User.find_by(uniqname: uniqname).display_name} - #{uniqname}" : "#{uniqname}"
  end

  def render_flash_stream
    turbo_stream.update "flash", partial: "layouts/flash"
  end

  def show_department_fullname(id)
    Department.find(id).display_fullname
  end

  def show_department_shortname(id)
    Department.find(id).display_shortname
  end

  def show_role_title(id)
    Role.find(id).show_role_title
  end
end
