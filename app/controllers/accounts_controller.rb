class AccountsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_account
  
  def show
  end
  
  def literatures
    @literatures = paged(@user.literatures)
  end
  
  def edit
  end
  
  def update
    if @user.update_without_password params[:user]
      flash[:notice] = "Your settings have been saved."
      redirect_to edit_account_path(params[:id])
    else
      flash.now[:alert] = "Error saving changes."
      render :edit
    end  
    # devise logs out the user if they change their password
    sign_in(@user, :bypass => true)
  end
  
  protected
  def find_account
    if current_user.id.to_s != params[:id].to_s
      redirect_to account_path(current_user)
    else
      @user = User.find(params[:id])
    end
  end
end