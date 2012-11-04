class StoryNotifier < Notifier
  observe :story

  def after_create(story)
    user = story.user
    targets = user.watchers.all
    data = {
      "user_id" => user.id,
      "username" => user.name,
      "story_id" => story.id,
      "story_title" => story.title,
    }

    if series = story.series
      targets += series.watchers.all
      data["series_id"] = series.id
      data["series_title"] = series.title
      notify(targets, "series_update", data)
    else
      notify(targets, "story_create", data)
    end
  end

  def after_update(story)
    if story.series_id_changed? && (series = story.series)
      user = story.user
      targets = user.watchers.all
      data = {
        "user_id" => user.id,
        "username" => user.name,
        "story_id" => story.id,
        "story_title" => story.title,
        "series_id" => series.id,
        "series_title" => series.title,
      }
      notify(targets, "series_update", data)
    end
  end
end