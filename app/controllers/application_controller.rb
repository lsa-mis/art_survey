class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def role_object( title )
    Role.find_by(title: title)
  end
  # helper_method :role_object

  def is_user?(role)
    if Permission.where(role_id: role).present?
      permission_collection = Permission.where(role_id: role)
      Access.where(permission_id: permission_collection).pluck(:uniqname).include?(session[:user_uniqname])
    end
  end
  helper_method :is_user?

  def is_access_authorized?
    unless is_user?(role_object("SuperUser")) || is_user?(role_object("Department Administrator")) || is_user?(role_object("Recorder"))
      redirect_to root_path
    end
  end
  helper_method :is_access_authorized?
end
