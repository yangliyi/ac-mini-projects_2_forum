class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  layout "admin"

  protected

  def check_admin
    unless current_user.admin?
      raise ActiveRecord::RecordNotFound
    end
  end
end
