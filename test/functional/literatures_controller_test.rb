require 'test_helper'

class LiteraturesControllerTest < ActionController::TestCase

  test "should get index if logged out" do
    sign_out :user
    get :index
    assert_response :success
  end

  test "should get show/1 if logged out" do
    sign_out :user
    get :show, :id => 1
    assert_response :success
  end

  test "should get show/1 if logged in" do
    sign_in users(:two)
    get :show, :id => 1
    assert_response :success
  end


  test "should show for the owner of a deleted item" do
    sign_in users(:one)
    get :show, :id => 3
    assert_response 200
  end

  test "show should return a 403 for a deleted item" do
    sign_in users(:two)
    get :show, :id => 3
    assert_response 403
  end
  
  
  #test "new should get redirected if not logged in" do
  #  request.env["devise.mapping"] = Devise.mappings[:user] 
  #  sign_out :user
  #  get :new
  #  assert_redirected_to user_sign_in_path
  #end

  test "should get new if logged in" do
    sign_in users(:one)
    get :new
    assert_response :success
  end
  
  test "create should get redirected to literature if logged in" do
    sign_in users(:one)
    assert_difference('Literature.count') do
      post :create, :literature => {:title => "Hi", :contents => "<b>yippie!</b>"}
    end
    assert_redirected_to literature_path(assigns(:literature))
  end
  
  
  test "create should render edit if logged in and invalid data" do
    sign_in users(:one)
    assert_no_difference('Literature.count') do
      post :create, :literature => {:title => "", :contents => "<b>yippie!</b>"}
    end
    assert_response 200
  end
  
  
  test "should get edit if logged in as owner" do
    sign_in users(:one)
    get :edit, :id => 1
    assert_response :success
  end
  
  test "edit should 403 if not owner" do
    sign_in users(:two)
    get :edit, :id => 1
    assert_response 403
  end
  
  
  test "should get update if logged in as owner" do
    sign_in users(:one)
    post :update, :id => 1,:literature => {:title => "Hi", :contents => "<b>yippie!</b>"}
    assert_redirected_to literature_path(assigns(:literature))
  end
  
  
  test "should get not update if logged in as owner and sends invalid data" do
    sign_in users(:one)
    post :update, :id => 1,:literature => {:title => "", :contents => "<b>yippie!</b>"}
    assert_response 200
  end
  
  
  test "create should 403 if not owner" do
    sign_in users(:two)
    post :update, :id => 1,:literature => {:title => "Hi", :contents => "<b>yippie!</b>"}
    assert_response 403
  end
  
end
