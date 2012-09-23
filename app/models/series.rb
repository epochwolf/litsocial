class Series < ActiveRecord::Base
  attr_accessible :title
  attr_protected :user_id, :created_at, :updated_at, as: :admin

  scope :visible, scoped
  scope :sorted, order(:id.desc)

  belongs_to :user
  has_many :stories, order: :series_position.asc

  validates :title, :user_id, presence: true

  def visible?
    true
  end
end
