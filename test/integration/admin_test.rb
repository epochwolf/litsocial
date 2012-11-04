require 'test_helper'

class AdminTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "Member can't access the admin panel" do
    sign_in(create(:user))
    
    get_via_redirect "/admin"
    assert_equal "/account", path
  end
  
  test "Guest can't access the admin panel" do
    delete_via_redirect "/sign_out"
    assert_equal '/', path
    
    get_via_redirect "/admin"
    assert_equal "/sign_in", path
  end
  
  test "Admin can access the admin panel and browse around" do
    get "/sign_in"
    assert_response :success
    
    user = create(:admin)

    post_via_redirect "/sign_in", user: {:name => user.name, :password => "Password"}
    assert_equal "/", path
    
    get "/admin"
    assert_response :success
    
    get "/admin/stories"
    assert_response :success
    
    get "/admin/stories/1"
    assert_response :success
    
    get "/admin/stories/1/edit"
    assert_response :success

    get "/admin/series"
    assert_response :success
    
    get "/admin/series/1"
    assert_response :success
    
    get "/admin/series/1/edit"
    assert_response :success
    
    get "/admin/forum_categories"
    assert_response :success
    
    get "/admin/forum_categories/1"
    assert_response :success
    
    get "/admin/forum_categories/1/edit"
    assert_response :success

    get "/admin/forum_posts"
    assert_response :success
    
    get "/admin/forum_posts/1"
    assert_response :success
    
    get "/admin/forum_posts/1/edit"
    assert_response :success
    
    get "/admin/news_posts"
    assert_response :success
    
    get "/admin/news_posts/new"
    assert_response :success
    
    get "/admin/news_posts/1"
    assert_response :success
    
    get "/admin/news_posts/1/edit"
    assert_response :success
    
    get "/admin/pages"
    assert_response :success
    
    get "/admin/pages/new"
    assert_response :success
    
    get "/admin/pages/1"
    assert_response :success
    
    get "/admin/pages/1/edit"
    assert_response :success
    
    get "/admin/users"
    assert_response :success
    
    get "/admin/users/new"
    assert_response :success
    
    get "/admin/users/1"
    assert_response :success
    
    get "/admin/users/1/edit"
    assert_response :success
  end
end