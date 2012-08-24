source 'http://rubygems.org'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'
gem 'pg'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'redactor-rails'


# View stuff.
gem 'uuid'
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails', :git => 'git://github.com/anjlab/bootstrap-rails.git'
gem 'simple_form'
gem 'haml'
gem 'sanitize'
gem 'devise'
gem "omniauth-facebook"
#gem "rack-mini-profiler"


# Active Record
gem 'acts_as_list'
gem 'acts_as_tree'
gem 'squeel'
gem 'paper_trail'
gem 'pg_search'


#ActiveAdmin

#gem 'activeadmin', :git => "https://github.com/gregbell/active_admin.git", :ref => 'f92c7fec7a4a86f25b0495576518e1e4462711a7'
gem 'activeadmin', :git => "https://github.com/gregbell/active_admin.git", :branch => 'master'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'exception_notification'
gem 'rvm'
gem 'capistrano'
gem 'capistrano-ext'

group :development, :test do
  #gem 'ruby-debug19', :require => 'ruby-debug'
  #gem 'rails-dev-tweaks', '~> 0.5.1'
end

group :test do
  # Pretty printed test output
  #gem 'turn', '0.8.2', :require => false
  gem "capybara"
  gem "capybara-webkit"
  gem 'database_cleaner'
  gem "launchy"
end

group :production do
  gem 'unicorn'
end

