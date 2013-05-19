class Bookmark < ActiveRecord::Base
  attr_accessible :story_id, :user_id, :paragraph

  belongs_to :story
  belongs_to :user

  scope :visible, joins(:story).where(stories:{locked_at: nil, deleted: [false, nil]})
  scope :sorted, order("bookmarks.updated_at desc")

  validates_uniqueness_of :story_id, scope: :user_id
  validates_presence_of :paragraph
  
  def self.for(story, user)
    where(story_id: story, user_id: user).first
  end

  def percent_read
    ((paragraph.to_f / story.paragraph_count.to_f) * 100.0).round(0)
  end
end
