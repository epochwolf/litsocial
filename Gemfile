source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3'
gem 'pg'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'


# View stuff.
gem 'uuid'
gem 'less-rails'
gem 'twitter-bootstrap-rails', :git => 'http://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'twitter_bootstrap_form_for', :git => 'https://github.com/stouset/twitter_bootstrap_form_for'
gem 'haml'
gem 'sanitize'
gem 'devise'
gem "omniauth-facebook"


# Active Record
gem 'acts_as_list'
gem 'acts_as_tree'
gem 'squeel'
gem 'pg_search'


#ActiveAdmin
gem 'meta_search', '>= 1.1.0.pre'
gem 'activeadmin', :git => "https://github.com/gregbell/active_admin.git", :tag => 'v0.3.4' #:branch => 'master'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'exception_notification'
gem 'rvm'
gem 'passenger'
gem 'capistrano'
gem 'capistrano-ext'

group :development, :test do
  #gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'rails-dev-tweaks', '~> 0.5.1'
end

group :test do
  # Pretty printed test output
  #gem 'turn', '0.8.2', :require => false
end

group :production do
  gem 'unicorn'
end

