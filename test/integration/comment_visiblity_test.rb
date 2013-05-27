require 'test_helper'

# Browses around the site and makes sure you can see the proper content.
class CommentVisiblityTest < ActionDispatch::IntegrationTest
  fixtures :all

  setup do 
    sign_in(users(:member))
  end

  test "All 4 comments are visible" do
    get "/stories/2"
    assert_response 200

    assert_select "div.comments" do 
      assert_select "div#comment-1"
      assert_select "div#comment-2"
      assert_select "div#comment-3"
      assert_select "div#comment-4"
    end
  end

  # comment_id = 1
  test "Visible Comments Are Visible" do
    get "/stories/2"
    assert_response 200

    assert_select "div#comment-1" do
      assert_select 'p', :text => "I'm saying a nice thing."
    end
  end

  # comment_id = 2
  test "Deleted Comments Are Deleted" do
    get "/stories/2"
    assert_response 200

    assert_select "div#comment-2" do
      assert_select "p", :text => "Comment by epochwolf deleted"
    end
  end
  
  # comment_id = 3
  test "Locked Comments Are Locked" do
    get "/stories/2"
    assert_response 200

    assert_select "div#comment-3" do
      assert_select "p", :text => "Comment by epochwolf removed by administrator"
    end
  end

  # comment_id = 4
  test "Deleted and Locked Comments Are Deleted" do
    get "/stories/2"
    assert_response 200

    assert_select "div#comment-4" do
      assert_select "p", :text => "Comment by epochwolf removed by administrator"
    end
  end

end