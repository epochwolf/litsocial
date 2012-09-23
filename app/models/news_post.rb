class NewsPost < ActiveRecord::Base
  attr_accessible
  attr_protected as: :admin

  scope :visible, where{ published_at != nil }
  scope :sorted, order(:published_at.desc)

  belongs_to :user

  validates :title, :contents, :user_id, presence: true
end
