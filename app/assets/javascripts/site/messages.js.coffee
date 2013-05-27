Application.typeahead_cache = {}

source_function = (query, process) ->
    $.post '/user_lookup', {query: query}, (data)->
      process data

$('.typeahead').typeahead source: source_function, minLength: 3