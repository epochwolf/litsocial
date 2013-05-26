$ ->
  # Create
  $('.comments-form').on "submit", "#new_comment", (e)->
    e.preventDefault()
    self = $ this
    comments_div = $ ".comments"

    $.post("/comments", self.serialize()).done((data)->
      if data["success"]
        comments_div.append $ data["html"]
        $(".comments-form").remove()
        comment = $("#comment-#{data["comment_id"]}")
        comment.get(0).scrollIntoView()
        flash_tooltip comment, "Comment posted!"
      else
        self.replaceWith $ data["html"]
        initRichText $ "#new_comment"
        
    ).fail(()-> 
      alert("Something went wrong.")
    )

  # Edit
  $('.comments').on "click", "a[data-widget=\"edit-comment\"]", (e)->
    e.preventDefault()
    self = $ this
    comment_id = self.data("comment-id")
    comment_div = $ "#comment-#{comment_id}"

    $.get("/comments/#{comment_id}/edit").done((data)->
      old_html = comment_div.html()
      comment_div.replaceWith $ data["html"]
      comment_div = $("#comment-#{comment_id}")
      comment_div.data "old-html", old_html
      initRichText comment_div
    ).fail(()-> 
      alert("Something went wrong.")
    )

  # Cancel Edit
  $('.comments').on "click", "a[data-widget=\"cancel-edit-comment\"]", (e)->
    e.preventDefault()
    self = $ this
    comment_id = self.data("comment-id")
    comment_div = $("#comment-#{comment_id}")

    if old_html = comment_div.data "old-html"
      comment_div.html old_html

  # Update
  $('.comments').on "submit", "form", (e)->
    e.preventDefault()
    self = $ this
    comment_id = self.data("comment-id")
    comment_div = $("#comment-#{comment_id}")
    postdata = self.serialize()
    postdata["_method"] = "put"

    $.post(self.attr("action"), postdata).done((data)->
      if data["success"]
        comment_div.replaceWith $ data["html"]
        flash_tooltip $("#comment-#{comment_id}"), "Comment updated."
      else
        old_html = comment_div.data("old-html")
        comment_div.replaceWith $ data["html"]
        comment_div = $ "#comment-#{comment_id}"
        comment_div.data("old-html", old_html)
        initRichText comment_div

    ).fail(()-> 
      alert("Something went wrong.")
    )

  # Destroy
  $('.comments').on "click", "a[data-widget=\"delete-comment\"]", (e)->
    e.preventDefault()
    self = $ this
    comment_id = self.data("comment-id")
    comment_div = $("#comment-#{comment_id}")

    if confirm("Delete this comment?")
      $.post("/comments/#{comment_id}", "_method": "delete").done((data)->
        console.log(data)
        comment_div.replaceWith $ data["html"]
        flash_tooltip comment_div, "Comment removed."
      ).fail(()-> 
        alert("Something went wrong.")
      )