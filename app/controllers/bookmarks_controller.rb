class BookmarksController < ApplicationController
  before_filter :find_story, only: [:create_or_update, :destroy]

  def import
    @cookie_bookmark = CookieBookmark.new(cookies)
    @stories = Story.where(id: @cookie_bookmark.get_all.keys).includes(:user)
    if request.post?
      if import_bookmarks_from_cookies
        redirect_to return_path, :notice => "Your bookmarks have been imported."
      else
        flash.now[:error] = "Hmmm. Something didn't go right... You can try again if you want or skip the import."
        render layout: "pages"
      end
    else
      render layout: "pages"
    end
  end

  def create_or_update
    if set_bookmark @story, params[:paragraph]
      render json:{success: true}
    else
      render json:{error: "Unknown error."}, status: 500
    end
  rescue ActionDispatch::Cookies::CookieOverflow 
    render json:{error: "You have too many bookmarks. You'll need to create an account to save any more."}
  end

  def destroy
    if remove_bookmark @story
      render json:{success: true}
    else
      render json:{error: "No record to delete."}, status: 422
    end
  end

  private
  def find_story
    @story = Story.find(params[:story_id])
    unless @story.visible?
      render json:{error: 'Reading position not available for stories that aren\'t visible'}, status: 422
    end
  end
end