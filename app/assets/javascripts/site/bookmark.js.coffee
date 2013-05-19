$ ->
  # This js file requires the user be signed in.
  return unless Application.signed_in

  bookmark_position = $("#story-text").data("position")
  bookmark_paragraph = "paragraph-#{bookmark_position}"

  # Bookmarks Page
  $("table").on "click", "a[data-widget=remove_bookmark]", (e) -> 
    self = $(this)
    story_id = self.data("story-id")

    $.post("/bookmarks/#{story_id}", "_method": "delete").done((data)->
      flash_tooltip self.closest("td"), "Bookmark removed."
      self.remove()
    ).fail(()-> 
      alert("Something went wrong.")
    ) 


  # Story Page

  $("#story-text p[id]").each (e) -> 
    self = $(this)
    add_class = if bookmark_paragraph == self.attr("id") 
      "bookmark-saved"
    else
      ""
    html = "<i "+
      "class=\"icon-bookmark bookmark #{add_class}\" "+
      " data-position=\"#{parseInt(self.attr("id").replace("paragraph-", ""))}\" " +
      "></i>"
    self.prepend $(html)

  $("article.story").on "click", "#clear_bookmark", (e)->
    self = $(this)
    story_id = $("#story-text").data("story_id")
    $.post("/bookmarks/#{story_id}", "_method": "delete").done((data)->
      $("#bookmark-message").remove()
      $("#story-text i.bookmark-saved").removeClass("bookmark-saved")
    ).fail(()-> 
      alert("Something went wrong.")
    ) 


  $("#story-text").on "click", 'i.bookmark', (e) ->
    self = $(this)
    story_id = $("#story-text").data("story_id")

    if self.hasClass("bookmark-saved")
      $.post("/bookmarks/#{story_id}", "_method": "delete").done((data)->
        self.removeClass("bookmark-saved")
        flash_tooltip self, "Bookmark removed."
      ).fail(()-> 
        alert("Something went wrong.")
      ) 
    else
      $.post("/bookmarks/#{story_id}/#{self.data("position")}",  "_method": "put").done((data)->
        $("#story-text i.bookmark-saved").removeClass("bookmark-saved")
        flash_tooltip self, "Reading position saved."
        self.addClass("bookmark-saved")
      ).fail(()-> 
        alert("Something went wrong.")
      ) 