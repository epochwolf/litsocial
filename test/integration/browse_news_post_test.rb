require 'test_helper'

class BrowseNewsPostTest < ActionDispatch::IntegrationTest
  fixtures :all

  setup do 
    sign_in(:two)
  end

  test "Member sees published post on index" do
    get "/news"
    assert response.body =~ /MyPublishedPost/ 
  end

  test "Member doesn't see non-published post on index" do
    get "/news"
    assert response.body !~ /MyHiddenPost/ 
  end


  test "Member can access the published posts" do
    get "/news/1"
    assert_response :success
  end

  test "Member can't access the non-published posts" do
    assert_raise ActiveRecord::RecordNotFound do
      get "/news/2"
    end
  end
  
end