require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  setup do
    sign_out :user
  end
    
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show if published" do
    get :show, :id => pages(:published)
    assert_response :success
  end
  
  test "should get show a parent page by custom url" do
    get :show, :id => "goggles"
    assert_response :success
  end
  
  test "should get show a parent page by custom url with trailing slash" do
    get :show, :id => "goggles/"
    assert_response :success
  end

  test "should get show a child page by custom url with slash" do
    get :show, :id => "goggles/they-do-nothing"
    assert_response :success
  end
  
  test "should get show a child page by custom url" do
    get :show, :id => "faq"
    assert_response :success
  end
  

  test "should get not show if not published" do
    assert_raises(ActiveRecord::RecordNotFound) do
      get :show, :id => pages(:draft)
    end 
  end
end