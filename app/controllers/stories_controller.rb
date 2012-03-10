class StoriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_story, :except => [:index, :new, :create]
  before_filter :new_story, :only => [:new, :create]
  before_filter :check_permissions, :only => [:edit, :update, :destroy]
  
  def index
    @stories = paged(Story.includes(:user))
  end
  
  def show
    return show403 "This post has been removed by the author, sorry. :(" unless @story.visible? || @story.user == current_user
    @comments = paged(@story.comments.top_levels.includes(:user, {:children => :user}))
    render :template => "shared/literature"
  end
  
  def new
  end
  
  def create
    if @story.save
      redirect @story
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @story.update_attributes(params[:story])
      redirect @story
    else
      render :edit
    end
  end
  
  def destroy
    show403 "Deleting posts isn't supported yet. It should be added soon."
  end
  
  protected
  def find_story
    @story = Story.find(params[:id])
  end
  
  def new_story
    @story = current_user.stories.new(params[:story])
  end
  
  def check_permissions
    show403 "I'm sorry, I can't let you edit this post because it doesn't belong to you." if @story.user != current_user
  end
end