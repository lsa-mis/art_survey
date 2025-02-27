module ApplicationHelper

  def svg(svg)
    # Use public path for SVGs since this approach works correctly
    public_path = "/images/svg/#{svg}.svg"
    "<img src='#{public_path}' class='svg-icon' style='width: 15px; height: 15px;' alt='#{svg}'>".html_safe
  end

  def show_svg(type)
    type_str = type.to_s.downcase

    case
    when type_str.nil? || type_str.empty?
      svg("attachment-1483")
    when type_str.include?("text/plain")
      svg("text-1473")
    when type_str.include?("pdf") || type_str.include?("application/pdf") || type_str.include?("application/x-pdf") || type_str.include?("acrobat") || type_str.match?(/pdf/i)
      svg("pdf-3375")
    when type_str.include?("application/vnd.openxmlformats-officedocument.wordprocessingml.document") || type_str.include?("word") || type_str.include?("office") || type_str.include?("msword") || type_str.include?("doc")
      svg("office-1466")
    when type_str.include?("image/jpg") || type_str.include?("image/jpeg") || type_str.include?("image/png") || type_str.include?("jpg") || type_str.include?("jpeg") || type_str.include?("png")
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
