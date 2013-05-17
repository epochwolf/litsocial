class UsersController < ApplicationController
  before_filter :find_user, except: [:index]
  layout "users"

  def index
    @users = paged(User.sorted)
    render layout: 'pages'
  end

  def show
    render 'errors/user_banned' if @user.banned?
  end
  
  def stories
    @stories = paged(@user.stories.visible)
  end

  def series
    @series = paged(@user.series.visible)
  end

  def journals
    @journals = paged(@user.journals.visible)
  end

  def comments
  end

  def find_user
    @user = User.find(params[:id])
  end

end