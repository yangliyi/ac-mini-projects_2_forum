class Admin::ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_profile, :only => [:edit, :update]

  layout "admin"

  def edit
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = "個人資料修改成功！"
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end


  protected

  def set_profile
    @profile = User.find_by_username(params[:id]).profile
  end

  def profile_params
    params.require(:profile).permit(:bio)
  end

end
