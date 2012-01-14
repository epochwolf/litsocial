require 'test_helper'

class AccountsControllerTest < ActionController::TestCase

  test "show should redirect if account id does not match the current user" do
    sign_in users(:two)
    get :show, :id => 1
    assert_redirected_to account_path(2)
  end
  
  test "show should display if account id matches current user" do 
    sign_in users(:one)
    get :show, :id => 1
    assert_response :success
  end
  
  test "edit should redirect if account id does not match the current user" do
    sign_in users(:two)
    get :edit, :id => 1
    assert_redirected_to account_path(2)
  end
  
  test "edit should display if account id matches current user" do 
    sign_in users(:one)
    get :edit, :id => 1
    assert_response :success
  end
  
  test "edit should not crash if the user's facebook data is corrupted." do
    u = users(:invalid_facebook_data)
    sign_in u
    get :edit, :id => u.id
    assert_response :success
  end
end
