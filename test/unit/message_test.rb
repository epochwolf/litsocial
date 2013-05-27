require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  test "New comment notifies owner" do
    to = create(:user)
    from = create(:user)
    message = nil

    assert_difference "Notification.count" do
      message = from.sent_messages.create(to_name: to.name, message: "Yo!")
    end

    notification = Notification.sorted.first

    assert_equal "message_create", notification.template,   "Notification has wrong type"
    assert_equal message,          notification.notifiable, "Message isn't assigned to to notification"
    assert_equal to,               notification.user,       "To isn't assigned to notifications properly"

    data = notification.data
    assert_equal from.id,   data["from_id"]
    assert_equal from.name, data["from"]
  end
end
