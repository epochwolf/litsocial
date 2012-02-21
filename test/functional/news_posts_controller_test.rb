require 'test_helper'

class NewsPostsControllerTest < ActionController::TestCase

  test "should get index" do
    sign_out :user
    get :index
    assert_response :success
  end
  
  test "should get show if published" do
    sign_out :user
    get :show, :id => news_posts(:published)
    assert_response :success
  end
  
  test "should get not show if not published" do
    sign_out :user
    assert_raises(ActiveRecord::RecordNotFound) do
      get :show, :id => news_posts(:draft)
    end 
  end
end