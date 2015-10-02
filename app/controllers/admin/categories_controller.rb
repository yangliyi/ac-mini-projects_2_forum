class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_category, :only => [:edit, :update, :destroy]

  layout "admin"

  def new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "分類新增成功！"

      redirect_to admin_users_path
    else
      render admin_users_path
    end

  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "分類修改成功！"
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    if @category.posts.count == 0
      @category.destroy
      flash[:notice] = "分類刪除成功！"
      redirect_to admin_users_path
    else
      flash[:alert] = "有文章的分類不能刪除！"
      redirect_to admin_users_path
    end
  end


  protected

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def check_admin
    unless current_user.admin?
      raise ActiveRecord::RecordNotFound
    end
  end
end
