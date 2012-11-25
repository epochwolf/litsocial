# All connections use public keys, anyone putting a password in here and committing it gets their password
# login privileges permanently revoked.

set :rvm_ruby_string, '1.9.3-p327@litsocial' # ruby environment for staging/production
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

after 'deploy:restart', 'unicorn:restart'

namespace :deploy do

  namespace :shared do
    folders = []
    files = ["config/secrets.yml"]
    
    desc "Create the dirs in shared path."
    task :setup do
      folders.each do |folder|
        run "mkdir -p  #{shared_path}/#{folder}"
      end
      files.each do |file|
        run "mkdir -p #{shared_path}/#{File.dirname(file)} && touch #{shared_path}/#{file}"
      end
    end

    desc "Link dir from shared to common."
    task :create_symlink do
      (folders + files).each do |folder|
        run "rm -rf #{current_path}/#{folder}; ln -s #{shared_path}/#{folder} #{current_path}/#{folder}"
      end
    end

  end
end

after "deploy:setup", "deploy:shared:setup"
after "deploy:create_symlink", "deploy:create_symlink"
