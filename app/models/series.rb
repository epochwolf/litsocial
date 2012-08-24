class Series < ActiveRecord::Base
  default_scope order(:id.desc)

  attr_accessible :title
  attr_protected :created_at, :updated_at, as: :admin

  belongs_to :user
  has_many :stories, order: :series_position.desc

  validates :title, :user_id, presence: true


  def visible?
    true
  end
end
