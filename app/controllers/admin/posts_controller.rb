class Admin::PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin

  layout "admin"

  def index

  end

  def destroy

  end


  protected

  def check_admin
    unless current_user.admin?
      raise ActiveRecord::RecordNotFound
    end
  end

end
