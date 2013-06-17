class StoriesController < ApplicationController
  require_login except: [:index, :show]
  before_filter :find_story, except:[:index, :new, :create]
  before_filter :check_owner, only: [:edit, :update, :destroy]
  before_filter :block_edit_if_locked, only:[:edit, :update]

  def index
    @stories = paged(Story.visible.includes(:series, :user))
  end

  def show
    if !@story.visible? && !owner?(@story)
      render 'errors/story_403', status: 403
    else
      @user = @story.user
      render layout: 'users'
    end
  end

  def kindle
    if not @story.visible?
      render json:{status: "error", error: "Story not visible." }
    elsif not current_user.kindle?
      render json:{status: "error", error: "You don't have a kindle email configured." }
    else
      KindleMailer.story_email(current_user.kindle_email, @story).deliver
      render json:{status: "ok", message: "Story sent!" }
    end
  end

  def kindle_preview
    if not @story.visible?
      show403 "Story not available"
    else
      render text: KindleHtml::StoryWriter.new(@story).to_html
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
    @story.update_column :deleted, true
    redirect_to return_path(account_path), alert: "Story deleted"
  end

  private
  def find_story
    @story = Story.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render 'errors/404', locals: {thing: "Story"}
  end

  def check_owner
    redirect_to account_path, alert: "Not your story!" unless owner?(@story)
  end

  def block_edit_if_locked
    render 'errors/story_403' if @story.locked? || @story.deleted?
  end
end