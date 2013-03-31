class NewsPostsController < ApplicationController
  layout :pick_layout

  def index
    @news_posts = paged(NewsPost.visible)
  end

  def show
    @news_post = NewsPost.visible.find(params[:id])
  end

  private
  def pick_layout
    user_signed_in? ? 'messages' : 'pages'
  end
end