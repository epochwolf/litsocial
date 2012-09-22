class UsersController < ApplicationController

  def index
    @users = paged(User.visible)
  end

  def show
    @user = User.find(params[:id])
    render 'errors/user_banned' if @user.banned?
  end
  
end