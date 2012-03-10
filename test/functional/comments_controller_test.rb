require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
    
  test "Post a comment on a story" do
    sign_in users(:one)
    assert_difference('Comment.count') do
      post :create, comments:{commentable_type:"Story", commentable_id:'1', contents:"<b>yippie!</b>"}
    end
    assert_response :success
  end
  
  test "Post a comment on a poem" do
    sign_in users(:one)
    assert_difference('Comment.count') do
      post :create, comments:{commentable_type:"Poem", commentable_id:'1', contents:"<b>yippie!</b>"}
    end
    assert_response :success
  end
  
  test "Post a comment on a news post" do
    sign_in users(:one)
    assert_difference('Comment.count') do
      post :create, comments:{commentable_type:"NewsPost", commentable_id:'1', contents:"<b>yippie!</b>"}
    end
    assert_response :success
  end
end
