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

  def department_admins( department )
    #collection of a department's admins
    deptadmin_permissions = Permission.where(role_id: 14, department_id: department)
    deptadmin_accesses = Access.where(permission_id: deptadmin_permissions).pluck(:uniqname)
    deptadmin_object_collection = User.where(uniqname: deptadmin_accesses)
  end

  def department_recorders( department = nil )
    #collection of a department's recorders
    recorder_permissions = Permission.where(role_id: 15, department_id: department)
    recorder_accesses = Access.where(permission_id: recorder_permissions).pluck(:uniqname)
    recorder_object_collection = User.where(uniqname: recorder_accesses)
  end

end
