class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def role_object( title )
    Role.find_by(title: title)
  end
  helper_method :role_object

  def is_user_a?( role_title )
    permission_collection = Permission.where(role_id: role_object( role_title ))
    if permission_collection.exists?
      Access.where(permission_id: permission_collection).pluck(:uniqname).include?(session[:user_uniqname])
    end
  end
  helper_method :is_user_a?
  
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
  helper_method :check_for_authorized_access

  def super_user_access_authorized!
    redirect_to root_path unless is_super_user!
    flash.alert = "Not Authorized." unless is_super_user!
  end

  def super_user_department_admin_access_authorized!
    redirect_to root_path unless (is_super_user! || is_department_admin_user!)
    flash.alert = "Not Authorized." unless (is_super_user! || is_department_admin_user!)
  end

  def current_user_access
    Access.where(uniqname: session[:user_uniqname]).pluck(:permission_id)
  end

  def current_user_departments
    if is_super_user!
      Department.all
    else
      Department.where(id: Permission.where(id: current_user_access).pluck(:department_id).uniq)
    end
  end
  helper_method :current_user_departments

  def current_user_permissions
    Permission.where(department_id: current_user_departments)
  end

  def get_accesses_collection
    Access.where(permission_id: current_user_permissions)
  end
end
