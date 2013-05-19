class BookmarksController < ApplicationController
  require_login
  before_filter :find_bookmark

  def create_or_update
    @bookmark.paragraph = params[:paragraph]
    if @bookmark.save # There's no reason for this to fail but weird things happen...
      render json:{success: true}
    else
      render json:{error: "Record failed to save."}, status: 500
    end
  end

  def destroy
    unless @bookmark.new_record?
      @bookmark.destroy # I really hate there's no confirmation this worked. 
      render json:{success: true}
    else
      render json:{error: "No record to delete."}, status: 422
    end
  end

  private
  def find_bookmark
    if (story = Story.find(params[:story_id])).visible?
      @bookmark = Bookmark.for(story, current_user) || Bookmark.new(story_id: story.id, user_id: current_user.id)
    else
      render json:{error: 'Reading position not available for stories that aren\'t visible'}, status: 422
    end
  end
end