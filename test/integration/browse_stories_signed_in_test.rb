require 'test_helper'

# Browses around the site and makes sure you can see the proper content.
class BrowseStoriesSignedInTest < ActionDispatch::IntegrationTest
  fixtures :all

  setup do 
    sign_in(users(:epoch))
  end


  # Other user's published story

  test "Member sees other user's published story on index" do
    get "/stories"
    assert_response 200
    assert response.body =~ /MembersStory/ 
  end

  test "Member sees other user's published story on other user's homepage" do
    story = stories(:members_story)
    user = story.user
    get "/users/#{user.id}/stories"
    assert_response 200
    assert response.body =~ /MembersStory/ 
  end

  test "Member sees other user's published story" do
    story = stories(:members_story)
    get "/stories/#{story.id}"
    assert_response 200
    assert response.body =~ /MembersStory/ 
  end

  test "Member can't edit other user's published story" do
    story = stories(:members_story)
    get "/stories/#{story.id}/edit"
    assert_response 302
  end


  # Other user's locked story

  test "Member doesn't see other user's locked story on index" do
    story = stories(:locked)
    get "/stories"
    assert_response 200
    assert response.body !~ /BannedsLockedStory/ 
  end

  test "Member doesn't see other user's locked story on other user's homepage" do
    story = stories(:locked)
    user = story.user
    get "/users/#{user.id}/stories"
    assert_response 200
    assert response.body !~ /BannedsLockedStory/ 
  end

  test "Member doesn't see other user's locked story" do
    story = stories(:locked)
    get "/stories/#{story.id}"
    assert_response 403
    assert response.body !~ /BannedsLockedStory/ 
  end


  # Other user's deleted story

  test "Member doesn't see other user's deleted story on index" do
    get "/stories"
    assert_response 200
    assert response.body !~ /BannedsDeletedStory/ 
  end

  test "Member doesn't see other user's deleted story on other user's homepage" do
    story = stories(:deleted)
    user = story.user
    get "/users/#{user.id}/stories"
    assert_response 200
    assert response.body !~ /BannedsDeletedStory/ 
  end

  test "Member doesn't see other user's deleted story but can see the title." do
    story = stories(:deleted)
    get "/stories/#{story.id}"
    assert_response 403
    assert response.body =~ /BannedsDeletedStory/ 
  end


  # User's published story

  test "Member sees own published story on index" do
    get "/stories"
    assert_response 200
    assert response.body =~ /EpochsStory/ 
  end

  test "Member sees own published story on own homepage" do
    story = stories(:epochs_story)
    user = story.user
    get "/users/#{user.id}/stories"
    assert_response 200
    assert response.body =~ /EpochsStory/ 
  end

  test "Member sees own published story" do
    story = stories(:epochs_story)
    get "/stories/#{story.id}"
    assert_response 200
    assert response.body =~ /EpochsStory/ 
  end

  test "Member can view new story form" do
    get "/stories/new"
    assert_response 200
  end

  test "Member can edit own published story" do
    story = stories(:epochs_story)
    get "/stories/#{story.id}/edit"
    assert_response 200
    assert response.body =~ /EpochsStory/ 
  end


  # User's deleted story

  test "Member doesn't see own deleted story on index" do
    get "/stories"
    assert_response 200
    assert response.body !~ /EpochsDeletedStory/ 
  end

  test "Member can't see own deleted story in series" do 
    story = stories(:epochs_deleted_series)
    series = story.series
    get "/series/#{series.id}"
    assert_response 200
    assert response.body !~ /EpochsDeletedStory/ 
  end

  test "Member doesn't see own deleted story on their homepage" do
    story = stories(:epochs_deleted)
    user = story.user
    get "/users/#{user.id}/stories"
    assert_response 200
    assert response.body !~ /EpochsDeletedStory/ 
  end

  test "Member can see own deleted story." do
    story = stories(:epochs_deleted)
    get "/stories/#{story.id}"
    assert_response 200
    assert response.body =~ /EpochsDeletedStory/ 
  end

  test "Member can't edit own deleted story." do
    story = stories(:epochs_deleted)
    get "/stories/#{story.id}/edit"
    assert_response 200
    assert response.body =~ /EpochsDeletedStory/ 
  end
  

  # User's locked story

  test "Member doesn't see own locked story on index" do
    get "/stories"
    assert_response 200
    assert response.body !~ /EpochsLockedStory/ 
  end

  test "Member can't see own locked story in series" do 
    story = stories(:epochs_locked_series)
    series = story.series
    get "/series/#{series.id}"
    assert_response 200
    assert response.body !~ /EpochsLockedStory/ 
  end

  test "Member doesn't see own locked story on their homepage" do
    story = stories(:epochs_locked)
    user = story.user
    get "/users/#{user.id}/stories"
    assert_response 200
    assert response.body !~ /EpochsLockedStory/ 
  end

  test "Member can see own locked story and the reason it's locked." do
    story = stories(:epochs_locked)
    get "/stories/#{story.id}"
    assert_response 200
    assert response.body =~ /This story has been locked/ 
    assert response.body =~ /I\'m cranky/ 
    assert response.body =~ /EpochsLockedStory/ 
  end

  test "Member can't edit own locked story but instead see reason it's locked." do
    story = stories(:epochs_locked)
    get "/stories/#{story.id}/edit"
    assert_response 200
    assert response.body =~ /Story not available/ 
    assert response.body =~ /I\'m cranky/ 
    assert response.body =~ /Delete Story/i
  end

end