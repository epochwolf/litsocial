$ ->
  $(document).on "click", 'a[data-widget="watch-link"]', (e) ->
    e.preventDefault()
    self = $(this)
    data = {watch:{watchable_type: self.data("class"), watchable_id: self.data("id")}}
    $.post('/watches/', data, replace_callback(self.data("replace")), 'json')

  $(document).on "click", 'a[data-widget="unwatch-link"]', (e) ->
    e.preventDefault()
    self = $(this)
    data = {"_method":"DELETE"}
    $.post('/watches/' + self.data("id"), data, replace_callback(self.data("replace")), 'json')

  $(document).on "click", 'a[data-widget="fav-link"]', (e) ->
    e.preventDefault()
    self = $(this)
    data = {fav:{favable_type: self.data("class"), favable_id: self.data("id")}}
    $.post('/favs/', data, replace_callback(self.data("replace")), 'json')

  $(document).on "click", 'a[data-widget="unfav-link"]', (e) ->
    e.preventDefault()
    self = $(this)
    data = {"_method":"DELETE"}
    $.post('/favs/' + self.data("id"), data, replace_callback(self.data("replace")), 'json')

  $(document).on "click", 'a[data-widget="report-link"]', (e) ->
    e.preventDefault()
    self = $(this)
    if report = window.prompt "Please describe the reason you filing a report:"
        data = {report:{reportable_type: self.data("class"), reportable_id: self.data("id"), reason: report}}
        $.post('/reports/', data, replace_callback(self.data("replace")), 'json')