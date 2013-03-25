require 'test_helper'

class BrowseStoriesSignedOutTest < ActionDispatch::IntegrationTest
  fixtures :all

  setup do 
    sign_out
  end


  # Other user's published story

  test "Guest sees other user's published story on index" do
    get "/stories"
    assert_response 200
    assert response.body =~ /MembersStory/ 
  end

  test "Guest sees other user's published story on other user's homepage" do
    story = stories(:members_story)
    user = story.user
    get "/users/#{user.id}"
    assert_response 200
    assert response.body =~ /MembersStory/ 
  end

  test "Guest sees user's published story" do
    story = stories(:members_story)
    get "/stories/#{story.id}"
    assert_response 200
    assert response.body =~ /MembersStory/ 
  end

  test "Guest can't edit user's published story" do
    story = stories(:members_story)
    get "/stories/#{story.id}/edit"
    assert_response 302
  end


  # User's locked story

  test "Guest doesn't see user's locked story on index" do
    story = stories(:locked)
    get "/stories"
    assert_response 200
    assert response.body !~ /BannedsLockedStory/ 
  end

  test "Guest doesn't see user's locked story on user's homepage" do
    story = stories(:locked)
    user = story.user
    get "/users/#{user.id}"
    assert_response 200
    assert response.body !~ /BannedsLockedStory/ 
  end

  test "Guest doesn't see user's locked story" do
    story = stories(:locked)
    get "/stories/#{story.id}"
    assert_response 403
    assert response.body !~ /BannedsLockedStory/ 
  end


  # User's deleted story

  test "Guest doesn't see user's deleted story on index" do
    get "/stories"
    assert_response 200
    assert response.body !~ /BannedsDeletedStory/ 
  end

  test "Guest doesn't see user's deleted story on user's homepage" do
    story = stories(:deleted)
    user = story.user
    get "/users/#{user.id}"
    assert_response 200
    assert response.body !~ /BannedsDeletedStory/ 
  end

  test "Guest doesn't see user's deleted story but can see the title." do
    story = stories(:deleted)
    get "/stories/#{story.id}"
    assert_response 403
    assert response.body =~ /BannedsDeletedStory/ 
  end

  
end