require 'test_helper'

class SendToKindleTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "User with kindle email can send series to kindle" do
    sign_in(users(:member))

    assert_difference "ActionMailer::Base.deliveries.count" do 
      post "/series/1/kindle"

      assert_response 200
      hash = JSON.parse response.body
      assert_equal "ok", hash["status"]
    end
    
    email = ActionMailer::Base.deliveries.last
    assert_equal 1,                           email.to.count, "More than one email in the to field"
    assert_equal users(:member).kindle_email, email.to.first, "Sent to the wrong email"
    assert_equal "Series: EpochsSeries",       email.subject, "Wrong subject"
    assert_equal 1,                           email.attachments.count, "Wrong number of attachments"

    attachment = email.attachments.first
    body = attachment.body.to_s
    assert_equal "EpochsSeries.html",  attachment.filename, "Wrong attachment filename"
    assert_match /EpochsSeries/,       body, "Attachment missing title"
    assert_match /epochwolf/,         body, "Attachment missing author"
    assert_match /EpochsStory1/,      body, "can't find story1 title"
    assert_match /MyString1/,         body, "can't find story1 contents"
    assert_match /EpochsStory2/,      body, "can't find story2 title"
    assert_match /MyString2/,         body, "can't find story2 contents"

  end

  test "User without kindle email can't send series to kindle" do
    sign_in(users(:epoch))
    
    post "/series/1/kindle"

    assert_response 200
    hash = JSON.parse response.body
    assert_equal "error", hash["status"]
  end


  test "User with kindle email can send story to kindle" do
    sign_in(users(:member))

    assert_difference "ActionMailer::Base.deliveries.count" do 
      post "/stories/1/kindle"

      assert_response 200
      hash = JSON.parse response.body
      assert_equal "ok", hash["status"]
    end
    
    email = ActionMailer::Base.deliveries.last
    assert_equal 1,                           email.to.count, "More than one email in the to field"
    assert_equal users(:member).kindle_email, email.to.first, "Sent to the wrong email"
    assert_equal "Story: EpochsStory",        email.subject, "Wrong subject"
    assert_equal 1,                           email.attachments.count, "Wrong number of attachments"

    attachment = email.attachments.first
    body = attachment.body.to_s
    assert_equal "EpochsStory.html",  attachment.filename, "Wrong attachment filename"
    assert_match /EpochsStory/,       body, "Attachment missing title"
    assert_match /epochwolf/,         body, "Attachment missing author"
    assert_match /MyString/,          body, "Attachment missing story"
  end

  test "User without kindle email can't send story to kindle" do
    sign_in(users(:epoch))
    
    post "/stories/1/kindle"

    assert_response 200
    hash = JSON.parse response.body
    assert_equal "error", hash["status"]
  end
end