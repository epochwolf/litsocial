require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "New comment notifies owner" do
    story_owner = create(:user)
    commenter = create(:user)
    story = create(:story, user: story_owner)
    comment = nil
    assert_difference "Notification.count" do
      comment = story.comments.new(contents: "It's a comment!")
      comment.user = commenter
      comment.save
    end
    notification = Notification.sorted.first

    assert_equal "comment_create", notification.template,   "Notification has wrong type"
    assert_equal comment,          notification.notifiable, "Comment isn't assigned to to notification"
    assert_equal story_owner,      notification.user,       "Story owner isn't assigned to notifications properly"

    data = notification.data
    assert_equal commenter.id,           data["user_id"]
    assert_equal commenter.name,         data["username"]
    assert_equal comment.id,             data["comment_id"]
    assert_equal comment.contents,       data["comment_body"]
    assert_equal "Story",                data["commentable_type"]
    assert_equal story.id,               data["commentable_id"]
    assert_equal story.title,            data["commentable_title"]
    assert_equal "/stories/#{story.id}", data["commentable_url"]
  end

  test "New comment by owner, doesn't notify owner" do 
    story_owner = create(:user)
    story = create(:story, user: story_owner)

    assert_no_difference "Notification.count" do
      story.comments.new(contents: "It's a comment!").tap{|c| c.user = story_owner }.save
    end
  end
end
