class HomeController < ApplicationController
  def index
    @stories = Story.includes(:user, :series).visible.sorted.limit(30)
    @news_posts = NewsPost.includes(:user).visible.sorted.limit(4)
    @forum_posts = ForumPost.includes(:user).where{sunk != true}.visible.sorted.limit(6)
    @user = User.where(banned_at: nil).order(:id.desc).limit(15)
  end

  def convert_word_doc
    if params[:word_doc].respond_to? :tempfile
      file = File.join(Rails.root, "tmp", params[:word_doc].original_filename)
      begin
        FileUtils.cp(params[:word_doc].tempfile.path, file)
        @text = WordConverter.html_from_file(file)
      ensure
        FileUtils.rm(file)
      end
    else
      @text = params.inspect
    end
    @text = @text.html_safe
    render :layout => nil
  end
end