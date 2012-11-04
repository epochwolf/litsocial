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
    assert notifications.all?{|n| n.user }, "Users aren't assigned to notifications properly"
  end

  # test "New story in series generates proper notifications" do
  #   raise "Not Implemented"
  # end

  # test "Adding story to series generates proper notifications" do
  #   raise "Not Implemented"
  # end
end
