class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_user, :only => [:edit, :update]

  layout "admin"

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "文章修改成功！"
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  protected

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :role)
  end

  def check_admin
    unless current_user.admin?
      raise ActiveRecord::RecordNotFound
    end
  end
end
