class UsersController < ApplicationController
  before_action :super_user_access_authorized!
  before_action :set_role, only: %i[ show ]
  def index
    @users = User.all
  end

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @user = User.find(params[:id])
  end
end
