class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def role_object( title )
    Role.find_by(title: title)
  end
  helper_method :role_object

  def is_user_a?( role_title )
    if Permission.where(role_id: role_object( role_title )).exists?
      permission_collection = Permission.where(role_id: role_object( role_title ))
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

  def access_authorized!
   if Access.all.pluck(:uniqname).include?(session[:user_uniqname])
      true
   end
  end
  helper_method :access_authorized!

  def super_user_access_authorized!
    redirect_to root_path unless is_super_user!
    flash.alert = "Not Authorized." 
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

end
