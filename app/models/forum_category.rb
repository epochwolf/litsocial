class ForumCategory < ActiveRecord::Base
  attr_accessible
  attr_accessible :title, as: :admin

  scope :sorted, order(:title.asc)

  has_many :forum_posts, inverse_of: :forum_category
end