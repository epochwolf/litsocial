class ForumPost < ActiveRecord::Base
  has_paper_trail
  attr_accessible :contents, :forum_category_id, :title
  attr_protected :user_id, as: :admin

  has_many :comments, :as => :commentable, :order => :id.asc

  scope :visible, where{ (deleted == false) | (deleted == nil) }

  scope :deleted, where(deleted: true)
  scope :sorted, order(:bumped_at.desc)

  belongs_to :forum_category
  belongs_to :user

  validates :title, :contents, :user_id, :forum_category_id, presence: true

  before_create :bump

  def visible?
    !deleted?
  end

  def bump
    self.bumped_at = DateTime.now unless sunk?
  end

  def bump!
    update_column :bumped_at, DateTime.now unless sunk?
  end
end
