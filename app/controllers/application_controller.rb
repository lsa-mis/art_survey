class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def role_object( title )
    Role.find_by(title: title)
  end
  helper_method :role_object

  def is_user_a?(role)
    if Permission.where(role_id: role).exists?
      permission_collection = Permission.where(role_id: role)
      Access.where(permission_id: permission_collection).pluck(:uniqname).include?(session[:user_uniqname])
    end
  end
  helper_method :is_user_a?(role)
  
  def is_super_user!
    if is_user?("SuperUser")
      true
    end
  end
  helper_method :is_super_user!

  def access_authorized!
    Access.all.pluck(:uniqname).include?(session[:user_uniqname])
      true
  end
  helper_method :access_authorized!
end
