class Admin::PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin

  layout "admin"

  def index

  end

  def destroy

  end

end
