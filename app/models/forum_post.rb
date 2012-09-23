class ForumPost < ActiveRecord::Base
  attr_accessible :contents, :forum_category_id, :title
  attr_protected :user_id, as: :admin

  scope :visible, where(deleted: nil)
  scope :sorted, order(:bumped_at.desc)

  belongs_to :forum_category

  before_create :bump

  def bump
    self.bumped_at = DateTime.now unless sunk?
  end

  def bump!
    update_column :bumped_at, DateTime.now unless sunk?
  end
end
