class Story < ActiveRecord::Base
  default_scope order(:id.desc)
  acts_as_list column: :series_position, scope: :series

  attr_accessible :contents, :series_id, :series_position, :title
  attr_protected :created_at, :updated_at, as: :admin

  belongs_to :series, counter_cache: true
  belongs_to :user

  validates :title, :contents, :user_id, presence: true


  def visible?
    !(deleted? || locked?)
  end

  def self.visible
    where{ (deleted == false) & (locked_at == nil) }
  end

  def locked?
    locked_at ? true : false
  end
end
