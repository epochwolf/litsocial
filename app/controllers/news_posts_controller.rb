class NewsPostsController < ApplicationController
  def index
    @news_posts = paged(NewsPost.visible)
  end

  def show
    @news_post = NewsPost.visible.find(params[:id])
  end
end