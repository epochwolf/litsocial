class NewsPostsController < ApplicationController

  def index
  	@posts = paged(NewsPost.visible, :per_page => 5)
  end

  def show
    @post = NewsPost.visible.find(params[:id])
    @comments = paged(@post.comments.top_levels.includes(:user, {:children => :user}))
  end
end