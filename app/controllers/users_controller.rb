class UsersController < ApplicationController

  def index
    @users = paged(User.visible)
  end

  def show
    @user = User.find(params[:id])
  end
  
end