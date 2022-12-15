class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def role_object( title )
    Role.find_by(title: title)
  end

  def is_user_a?( role_title )
    permission_collection = Permission.where(role_id: role_object( role_title ))
    if permission_collection.exists?
      Access.where(permission_id: permission_collection).pluck(:uniqname).include?(session[:user_uniqname])
    end
  end
  
  def is_super_user!
    if is_user_a?("SuperUser")
      true
    end
  end
  helper_method :is_super_user!

  def is_department_admin_user!
    if is_user_a?("Department Administrator")
      true
    end
  end
  helper_method :is_department_admin_user!

  def access_authorized!
   if Access.all.pluck(:uniqname).include?(session[:user_uniqname])
      true
   end
  end
  helper_method :access_authorized!

  def check_for_authorized_access
    redirect_to root_path unless access_authorized!
    flash.alert = "Not Authorized." unless access_authorized!
  end

  def super_user_access_authorized!
    redirect_to root_path unless is_super_user!
    flash.alert = "Not Authorized." unless is_super_user!
  end

  def super_user_department_admin_access_authorized!
    redirect_to root_path unless (is_super_user! || is_department_admin_user!)
    flash.alert = "Not Authorized." unless (is_super_user! || is_department_admin_user!)
  end

  def current_user_access
    Access.where(uniqname: session[:user_uniqname])
  end

  def current_department_admin_user_department_permissions_collection
    Permission.where(id: current_user_access.pluck(:permission_id), role_id: role_object( "Department Administrator" ))
  end

  def current_user_permissions
    if is_super_user!
      Permission.all
    elsif is_department_admin_user!
      current_department_admin_user_department_permissions_collection
    else
      Permission.where(id: current_user_access.pluck(:permission_id))
    end
  end

  def current_user_associated_department_permissions
    Permission.where(department_id: current_user_permissions.pluck(:department_id))
  end

  def current_user_departments
    if is_super_user!
      Department.all
    elsif is_department_admin_user!
      Department.where(id: current_department_admin_user_department_permissions_collection.pluck(:department_id))
    else
      Department.where(id: current_user_permissions.pluck(:department_id)).uniq
    end
  end

  def get_accesses_collection
    if is_super_user!
      Access.all
    elsif is_department_admin_user!
      Access.where(permission_id: current_department_admin_user_department_permissions_collection + current_user_associated_department_permissions)
    else
      current_user_access
    end
  end
end
