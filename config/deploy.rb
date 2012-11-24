# All connections use public keys, anyone putting a password in here and committing it gets their password
# login privileges permanently revoked.

set :rvm_ruby_string, '1.9.2-p136@sf-final' # ruby environment for staging/production
set :rvm_type, :system 
require "rvm/capistrano"
require "bundler/capistrano"

# server info
set :user, "litsocial"  # The server's user for deploys
set :application, "litsocial.com"
set :deploy_to, "/home/litsocial/htdocs"
set :use_sudo, false

# SCM info
set :repository, "https://github.com/epochwolf/litsocial.git"  # Your clone URL
set :scm, "git"
set :branch, "master"

set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true
ssh_options[:compression] = false

set :rails_env, "production"
server "kazan.epochwolf.com", :app, :web, :db, :primary => true


require 'capistrano-unicorn'

after 'deploy:restart', 'unicorn:restart' # app IS NOT preloaded