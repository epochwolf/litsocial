class AccountController < ApplicationController
  before_filter :find_model
  layout 'account'

  def show
  end

  def stories
    @series = @user.series.includes(:stories)
    @stories = @user.stories.where(series_id: nil)
  end

  def forums
    @forum_posts = paged(@user.forum_posts)
  end

  def watches
    @watches = paged(@user.watches)
    render layout: 'messages'
  end

  def favs
    @favs = paged(@user.favs)
  end

  def notifications
    @notifications = paged(@user.notifications)
    render layout: 'messages'
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash.now[:notice] = "Changes saved."
    else
      flash.now[:alert] = "Error saving changes!"
    end
    render :edit
  end

  def cancel
    raise "Not Implemented"
  end

  def destroy
    raise "Not Implemented"
  end

  private
  def find_model
    redirect_to new_user_session_path unless @user = current_user 
  end
end