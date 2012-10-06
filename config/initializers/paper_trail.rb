# config/initializers/paper_trail.rb
class Version < ActiveRecord::Base
  attr_accessible :ip_address, :user_agent
end