require 'test_helper'

class AdminTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "Member can't access the admin panel" do
    sign_in(:two)
    
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
    
    post_via_redirect "/sign_in", :user => {:name => users(:one).name, :password => "Password"}
    assert_equal "/", path
    
    ["/admin", "/admin/stories", "/admin/stories/1", "/admin/stories/1/edit",
    "/admin/series", "/admin/series/1", "/admin/series/1/edit", "/admin/forum_categories",
    "/admin/forum_categories/1", "/admin/forum_categories/1/edit", "/admin/forum_posts",
    "/admin/forum_posts/1", "/admin/forum_posts/1/edit", "/admin/news_posts",
    "/admin/news_posts/new", "/admin/news_posts/1", "/admin/news_posts/1/edit",
    "/admin/pages", "/admin/pages/new", "/admin/pages/1", "/admin/pages/1/edit",
    "/admin/users", "/admin/users/new", "/admin/users/1", "/admin/users/1/edit"].each do |path|
      get path
      assert_response :success
    end
  end
end