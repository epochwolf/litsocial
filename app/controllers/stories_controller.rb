class StoriesController < ApplicationController
  require_login except: [:index, :show]
  before_filter :find_story, except:[:index, :new, :create]

  def index
    @stories = paged(Story.visible.includes(:series, :user))
  end

  def show
    if !@story.visible? && !owner?(@story)
      show403 "Story not available"
    end
  end

  def new
    @story = current_user.stories.build(series_id: params[:series])
  end

  def create
    @story = current_user.stories.build(params[:story])
    if @story.save
      redirect_to return_path(@story), notice: "Story saved!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @story.update_attributes(params[:story])
      redirect_to return_path(@story), notice: "Story updated!"
    else
      render :edit
    end
  end

  def destroy
    @story.update_column :deleted_at, Time.now.utc
    redirect_to return_path(account_path), alert: "Story deleted"
  end

  private
  def find_story
    @story = Story.find(params[:id])
    redirect_to account_path, alert: "Not your story!" if params[:action] != "show" && !owner?(@story)
  end
end