require 'test_helper'

class BrowseForumTest < ActionDispatch::IntegrationTest
  fixtures :all

  setup do 
    sign_in(create(:user))
  end

  test "Member sees both posts on index" do
    get "/forums"
    assert_response :success
    assert response.body =~ /ForumPostOne/
    assert response.body =~ /ForumPostTwo/
  end

  test "Member sees both posts on category" do
    get "/forums/categories/1"
    assert_response :success
    assert response.body =~ /ForumPostOne/
    assert response.body =~ /ForumPostTwo/
  end

  test "Member doesn't see deleted post on index" do
    get "/forums"
    assert_response :success
    assert response.body !~ /ForumPostDelete/ 
  end

  test "Member doesn't see deleted post on category" do
    get "/forums/categories/1"
    assert_response :success
    assert response.body !~ /ForumPostDelete/ 
  end

  test "Member can access the two posts" do
    get "/forums/1"
    assert_response :success
    assert response.body !~ /ForumPostTwo/
    assert response.body =~ /ForumPostOne/

    get "/forums/2"
    assert_response :success
    assert response.body !~ /ForumPostOne/
    assert response.body =~ /ForumPostTwo/
  end


  test "Member can't access the deleted posts" do
    assert_raise ActiveRecord::RecordNotFound do
      get "/forums/3"
    end
  end
end