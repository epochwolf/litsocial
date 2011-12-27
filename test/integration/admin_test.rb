require 'test_helper'

class AdminTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "Member can't access the admin panel" do
    sign_in(:two)
    
    get "/admin"
    assert_response :success
  end
  
  test "Guest can't access the admin panel" do
    delete_via_redirect "/users/sign_out"
    assert_equal '/', path
    
    get_via_redirect "/admin"
    assert_equal "/users/sign_in", path
  end
  
  test "Admin can access the admin panel and browse around" do
    get "/users/sign_in"
    assert_response :success
    
    post_via_redirect "/users/sign_in", :user => {:email => users(:one).email, :password => "Password"}
    assert_equal "/users/1", path
    
    get "/admin"
    assert_response :success
    
    get "/admin/literatures"
    assert_response :success
    
    get "/admin/literatures/1"
    assert_response :success
  end
end
