require 'test_helper'

class DeviseLayoutTest < ActionDispatch::IntegrationTest
  fixtures :all

  setup do 
    sign_out
  end

  test "Sign up and Forgot Password links are visible from Sign In page" do
    get "/sign_in"
    assert_response 200

    assert_select "label", :text => "Name"
    assert_select "label", :text => "Password"
    assert_select 'a', :text => "Sign up"
    assert_select 'a', :text => "Forgot your password?"
  end

  test "Sign in and Forgot Password links are visible from Sign Up page" do
    get "/sign_up"
    assert_response 200

    assert_select "label", :text => "* Username"
    assert_select "label", :text => "* Email"
    assert_select "label", :text => "* Password"
    assert_select "label", :text => "* Confirm password"
    assert_select 'a', :text => "Sign in"
    assert_select 'a', :text => "Forgot your password?"
  end

  test "Forgot password" do 
    get "/forgot_password"
    assert_response 200

    assert_select "label", :text => "* Name"
    assert_select 'a', :text => "Sign in"
    assert_select 'a', :text => "Sign up"
  end


end