class ProfilesController < ApplicationController

  before_action :set_profile, :only => [:show, :edit, :update]

  def new
    @profile = Profile.new
  end

  def show
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user

    if @profile.save
      flash[:notice] = "你的個人檔案新增成功！"
      redirect_to profile_path(@profile)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = "個人資料修改成功！"
      redirect_to profile_path(@profile)
    else
      render 'edit'
    end
  end

  private

  def set_profile
    @profile = User.find_by_username(params[:id]).profile
  end

  def profile_params
    params.require(:profile).permit(:bio)
  end

end
