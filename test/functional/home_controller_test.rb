require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  
  test "show root page when logged out" do
    sign_out :user
    get :index
    assert_response :success
  end

  test "show root page when logged in" do
    sign_in users(:two)
    get :index
    assert_response :success
  end
  
  test "show 403 error page when logged out" do
    sign_out :user
    get :four_oh_three
    assert_response 403
  end

  test "show 403 error page when logged in" do
    sign_in users(:two)
    get :four_oh_three
    assert_response 403
  end
  
  test "show 404 error page when logged out" do
    sign_out :user
    get :four_oh_four
    assert_response 404
  end
  
  test "show 404 error page when logged in" do
    sign_in users(:two)
    get :four_oh_four
    assert_response 404
  end

end
