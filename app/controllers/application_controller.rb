class ApplicationController < ActionController::Base
  before_action :authenticate_user!


  def superuser_role_object
    Role.find_by(title: "SuperUser")
  end
  helper_method :superuser_role_object

  def department_admin_role_object
    Role.find_by(title: "Department Administrator")
  end
  helper_method :department_admin_role_object

  def recorder_role_object
    Role.find_by(title: "Recorder")
  end
  helper_method :recorder_role_object

  def is_super_user?
    #current_user.uniqname has an access that includes the role superuser
    if Permission.where(role_id: superuser_role_object).present?
      permission_collection = Permission.where(role_id: superuser_role_object)
      Access.where(permission_id: permission_collection).pluck(:uniqname).include?(session[:user_uniqname])
    end
  end
  helper_method :is_super_user?

  def is_department_admin?
    #current_user.uniqname has an access that is a department_admin
    if Permission.where(role_id: department_admin_role_object).present?
      permission_collection = Permission.where(role_id: department_admin_role_object)
      Access.where(permission_id: permission_collection).pluck(:uniqname).include?(session[:user_uniqname])
    end
  end
  helper_method :is_department_admin?

  def is_recorder?
    #current_user.uniqname has an access that is a recorder
    if Permission.where(role_id: recorder_role_object).present?
      permission_collection = Permission.where(role_id: recorder_role_object)
      Access.where(permission_id: permission_collection).pluck(:uniqname).include?(session[:user_uniqname])
    end
  end
  helper_method :is_recorder?

  def is_access_authorized?
    unless is_super_user? || is_department_admin? || is_recorder?
      redirect_to root_path
    end
  end
  helper_method :is_access_authorized?
end
