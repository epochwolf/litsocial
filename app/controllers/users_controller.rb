class UsersController < ApplicationController
  before_filter :find_user
  
  def show
  end
  
  def literatures
    @literatures = paged(@user.literatures)
  end
    
  protected
  def find_user
    @user = User.find(params[:id])
  end
end