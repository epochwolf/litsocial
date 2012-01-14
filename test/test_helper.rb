ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  #include Devise::TestHelpers
end

class ActionController::TestCase
  include Devise::TestHelpers
end


class ActionDispatch::IntegrationTest
  def sign_out
    delete_via_redirect "/users/sign_out"
    assert_equal '/', path
  end
  
  def sign_in(fixture_id)
   get "/users/sign_in"
   assert_response :success
   
   post_via_redirect "/users/sign_in", :user => {:email => users(fixture_id).email, :password => "Password"}
   assert_equal "/users/#{users(fixture_id).id}", path
  end
end

OmniAuth.config.test_mode = true