class Series < ActiveRecord::Base
  #default_scope order(:id.desc)

  scope :sorted, order(:id.desc)
  scope :visible, scoped

  attr_accessible :title
  attr_protected :created_at, :updated_at, as: :admin

  belongs_to :user
  has_many :stories, order: :series_position.asc

  validates :title, :user_id, presence: true


  def visible?
    true
  end
end
