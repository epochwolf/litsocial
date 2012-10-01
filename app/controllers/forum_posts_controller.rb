class ForumPostsController < ApplicationController
  before_filter :find_forum_post, only: [:show, :edit, :update, :destroy]
  before_filter :new_forum_post, only: [:new, :create]

  def index
    @forum_posts = paged(ForumPost.visible)
  end

  def category
    @forum_category = ForumCategory.find(params[:id])
    @forum_posts = paged(@forum_category.forum_posts.visible)
  end

  def show
  end

  def new
  end

  def create
    if @forum_post.save
      redirect_to return_path(@forum_post)
    else
      render :new
    end
  end

  def edit
  end 

  def update
    if @forum_post.update_attributes(params[:forum_post])
      redirect_to return_path(@forum_post), notice: "Post updated."
    else
      render :edit
    end
  end

  def destroy
    @forum_post.update_column :deleted, true
    redirect_to return_path(account_path), alert: "Post deleted!"
  end

  private
  def new_forum_post
    @forum_post = current_user.forum_posts.new(params[:forum_post])
  end

  def find_forum_post
    @forum_post = ForumPost.visible.find(params[:id])
  end
end