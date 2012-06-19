class Category < ActiveRecord::Base
  has_and_belongs_to_many :stories
  attr_accessible :name
end
