class Admin::ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  layout "admin"

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash[:notice] = "文章修改成功！"
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end


  protected

  def profile_params
    params.require(:profile).permit(:bio)
  end

end
