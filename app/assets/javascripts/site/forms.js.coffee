$ -> 
  show_hide_series_title = (e) ->
    self = $('#story_series_id')
    target = $('#story_series_title').closest('.control-group')
    if self.val() == ""
      target.show()
    else
      target.hide()

  show_hide_series_title()
  $('form').on('change', '#story_series_id', show_hide_series_title)
