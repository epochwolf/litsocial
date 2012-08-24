class StoriesController < ApplicationController

  def index
    @stories = paged(Story.visible.includes(:series, :user))
  end

  def show
    @story = Story.find(params[:id])
    if !@story.visible? && !owner?(@story)
      show403 "Story not available"
    end  
  end
end