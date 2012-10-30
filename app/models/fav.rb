class Fav < ActiveRecord::Base
  attr_accessible :favable_type, :favable_id
  belongs_to :user
  belongs_to :favable, polymorphic: true
  
  validates :user_id, :favable_type, :favable_id, presence: true
end
