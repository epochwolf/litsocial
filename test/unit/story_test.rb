require 'test_helper'

class StoryTest < ActiveSupport::TestCase

  test "New story generates proper notifications" do
    poster = create(:user_with_watchers)
    count = Notification.count
    story = create(:story, user: poster)

    assert_equal count + 2, Notification.count
    notifications = Notification.sorted.limit(2)  

    assert notifications.all?{|n| n.template == "story_create" }, "Notification has wrong type"
    assert notifications.all?{|n| n.notifiable == story }, "Story isn't assigned to to notification"
    assert notifications.all?{|n| poster.watchers.include?(n.user) }, "Users aren't assigned to notifications properly"
    assert notifications.first.user != notifications.last.user, "The same user received two notifications"
  end

  test "New story in series generates proper notifications" do    
    poster = create(:user_with_watchers)
    series = create(:series, user: poster)
    count = Notification.count
    story = create(:story, user: poster, series: series)

    assert_equal count + 2, Notification.count
    notifications = Notification.sorted.limit(2)  

    assert notifications.all?{|n| n.template == "series_update" }, "Notification has wrong type"
    assert notifications.all?{|n| n.notifiable == series }, "Series isn't assigned to to notification"
    assert notifications.all?{|n| poster.watchers.include?(n.user) }, "Users aren't assigned to notifications properly"
    assert notifications.first.user != notifications.last.user, "The same user received two notifications"
  end

  test "Adding story to series generates proper notifications" do
    poster = create(:user_with_watchers)
    series = create(:series, user: poster)
    story = create(:story, user: poster)
    count = Notification.count

    story.series = series
    story.save!

    assert_equal count + 2, Notification.count
    notifications = Notification.sorted.limit(2)  

    assert notifications.all?{|n| n.template == "series_update" }, "Notification has wrong type"
    assert notifications.all?{|n| n.notifiable == series }, "Series isn't assigned to to notification"
    assert notifications.all?{|n| poster.watchers.include?(n.user) }, "Users aren't assigned to notifications properly"
    assert notifications.first.user != notifications.last.user, "The same user received two notifications"
  end
end
