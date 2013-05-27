require 'test_helper'

class StoryTest < ActiveSupport::TestCase

  test "New story generates proper notifications" do
    poster = create(:user_with_watchers)
    story = nil
    assert_difference "Notification.count", 2 do 
      story = create(:story, user: poster)
    end

    notifications = Notification.sorted.limit(2)  

    assert notifications.all?{|n| n.template == "story_create" }, "Notification has wrong type"
    assert notifications.all?{|n| n.notifiable == story }, "Story isn't assigned to to notification"
    assert notifications.all?{|n| poster.watchers.include?(n.user) }, "Users aren't assigned to notifications properly"
    assert notifications.first.user != notifications.last.user, "The same user received two notifications"

    data = notifications.first.data
    assert_equal poster.id,   data["user_id"]
    assert_equal poster.name, data["username"]
    assert_equal story.id,    data["story_id"]
    assert_equal story.title, data["story_title"]
    assert_equal nil,         data["series_id"]
    assert_equal nil,         data["series_title"]
  end

  test "New story in series generates proper notifications" do    
    poster = create(:user_with_watchers)
    series = create(:series, user: poster)
    story = nil
    assert_difference "Notification.count", 2 do 
      story = create(:story, user: poster, series: series)
    end

    notifications = Notification.sorted.limit(2)  

    assert notifications.all?{|n| n.template == "series_update" }, "Notification has wrong type"
    assert notifications.all?{|n| n.notifiable == series }, "Series isn't assigned to to notification"
    assert notifications.all?{|n| poster.watchers.include?(n.user) }, "Users aren't assigned to notifications properly"
    assert notifications.first.user != notifications.last.user, "The same user received two notifications"

    data = notifications.first.data
    assert_equal poster.id,    data["user_id"]
    assert_equal poster.name,  data["username"]
    assert_equal story.id,     data["story_id"]
    assert_equal story.title,  data["story_title"]
    assert_equal series.id,    data["series_id"]
    assert_equal series.title, data["series_title"]
  end

  test "Adding story to series generates proper notifications" do
    poster = create(:user_with_watchers)
    series = create(:series, user: poster)
    story = create(:story, user: poster)

    assert_difference "Notification.count", 2 do
      story.series = series
      story.save!
    end

    notifications = Notification.sorted.limit(2)  

    assert notifications.all?{|n| n.template == "series_update" }, "Notification has wrong type"
    assert notifications.all?{|n| n.notifiable == series }, "Series isn't assigned to to notification"
    assert notifications.all?{|n| poster.watchers.include?(n.user) }, "Users aren't assigned to notifications properly"
    assert notifications.first.user != notifications.last.user, "The same user received two notifications"

    data = notifications.first.data
    assert_equal poster.id,    data["user_id"]
    assert_equal poster.name,  data["username"]
    assert_equal story.id,     data["story_id"]
    assert_equal story.title,  data["story_title"]
    assert_equal series.id,    data["series_id"]
    assert_equal series.title, data["series_title"]
  end
end
