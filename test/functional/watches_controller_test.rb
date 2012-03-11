require 'test_helper'

class WatchesControllerTest < ActionController::TestCase

  test "create should work" do
    sign_in users(:three)
    post :create, :watch => {:watchable_type => "User", :watchable_id => 1}
    assert_response :success
    
    assert_equal "ok", json["status"]
  end
  
  test "destroy should work" do
    sign_in users(:two)
    post :create, :watch => {:watchable_type => "User", :watchable_id => 3}
    assert_response :success
    watch = assigns(:watch)
    
    delete :destroy, :id => watch.id
    assert_response :success
    
    assert_equal "ok", json["status"]
  end
  
  def json
    ActiveSupport::JSON.decode @response.body
  end
end
