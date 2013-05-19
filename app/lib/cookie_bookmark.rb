class CookieBookmark
  def initialize(cookies)
    @cookies = cookies
    read_from_cookie
  end

  def self.has_bookmarks?(cookies)
    cookies[:bookmarks_v1] ? true : false
  end

  def get(story_id)
    @data[story_id]
  end

  def set(story_id, paragraph)
    @data[story_id] = paragraph.to_i
    save_to_cookie
    true
  end

  def remove(story_id)
    @data.delete(story_id)
    save_to_cookie
    true
  end

  # => {story_id => paragraph}
  def get_all
    @data
  end

  def clear_all
    @cookies[:bookmarks_v1] = nil
  end

  protected

  def read_from_cookie
    @data = if (cookie_data = @cookies[:bookmarks_v1].presence) && Hash === (data = Marshal.load(cookie_data))
      data 
    else
      {}
    end
  end

  def save_to_cookie
    @cookies.permanent[:bookmarks_v1] = Marshal.dump(@data)
  end
end