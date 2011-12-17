require 'test_helper'

class ConvertControllerTest < ActionController::TestCase
  test "should get word_doc" do
    get :word_doc
    assert_response :success
  end

end
