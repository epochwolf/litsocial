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
end

class ActionController::TestCase
  include Devise::TestHelpers
end

# Test::Unit
class Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end


class ActionDispatch::IntegrationTest
  def sign_out
    delete_via_redirect "/sign_out"
    assert_equal '/', path
  end
  
  def sign_in(user)
    get "/sign_in"
    assert_response :success
   
    post_via_redirect "/sign_in", :user => {:name => user.name, :password => "Password"}
    #assert_equal "/users/#{users(fixture_id).id}", path
    assert_equal '/', path
  end
end