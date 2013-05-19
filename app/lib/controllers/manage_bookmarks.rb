# This class abstracts the concept of bookmarks so we can use a database or a cookie as the storage mechanism. 
module Controllers
module ManageBookmarks
  def self.included(mod)
    mod.helper_method :bookmark_for
  end

  # UNTESTED
  def import_bookmarks_from_cookies
    return false unless signed_in?
    if CookieBookmark.has_bookmarks?(cookies)
      cb = CookieBookmark.new(cookies)
      if Hash === (hash = cb.get_all)
        hash.each do |story, paragraph|
          set_bookmark(story, paragraph)
        end
        cb.clear_all
        return true
      end
    end
    return false
  end

  def bookmark_for(story)
    return unless story
    if signed_in?
      Bookmark.for(story, current_user).try(:paragraph)
    else
      CookieBookmark.new(cookies).get(story.id)
    end
  end

  def set_bookmark(story, paragraph)
    return unless story && paragraph
    story_id = Story === story ? story.id : story # For import...
    if signed_in?
      bookmark = Bookmark.for(story, current_user) || Bookmark.new(story_id: story_id, user_id: current_user.id)
      bookmark.paragraph = paragraph.to_i
      bookmark.save
    else
      CookieBookmark.new(cookies).set(story.id, paragraph)
    end
  end

  def remove_bookmark(story)
    return unless story
    if signed_in?
      Bookmark.for(story, current_user).tap{|b| b.try(:destroy) }
    else
      CookieBookmark.new(cookies).remove(story.id)
    end
  end
end
end