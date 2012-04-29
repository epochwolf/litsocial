class UsersController < ApplicationController
  before_filter :find_user
  
  def show
    @stories = @user.stories.recent(5)
  end
  
  def stories
    @stories = paged(@user.stories)
  end
    
  def poems
    @poems = paged(@user.poems)
  end
  
  def json_search
    users = User.search(params[:q], :current_user => current_user)
    json = Users.map{|u| [u.name, u.id] }
    render :json => json
  end

  protected
  def find_user
    @user = User.find(params[:id])
  end
end