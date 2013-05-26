require "test_helper"
require "capybara/rails"
require 'capybara/poltergeist'

DatabaseCleaner.strategy = :truncation
Capybara.javascript_driver = :poltergeist

class CapyTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Warden::Test::Helpers
  Warden.test_mode!
  
  self.use_transactional_fixtures = false
  
  setup do
    Capybara.current_driver = Capybara.javascript_driver
  end
  
  def sign_out
    logout(:user)
  end
  
  def sign_in(user)
    login_as(user, :scope => :user)
  end

  def fill_in_redactor(selector, text)
    page.execute_script("$(#{selector.to_s.to_json}).val(#{text.to_s.to_json})")
  end
  
  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end
end