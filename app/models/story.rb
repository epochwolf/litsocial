class Story < ActiveRecord::Base
  #default_scope order(:id.desc)
  acts_as_list column: :series_position, scope: :series
  
  scope :sorted, order(:id.desc)

  attr_accessible :contents, :series_id, :series_position, :title
  attr_protected :created_at, :updated_at, as: :admin

  belongs_to :series, counter_cache: true
  belongs_to :user

  validates :title, :contents, :user_id, presence: true

  def visible?
    !(deleted? || locked?)
  end

  def series?
    series_id
  end

  def self.visible
    where{ (deleted == false) & (locked_at == nil) }
  end

  def locked?
    locked_at ? true : false
  end

  # SERIES TITLE
  attr_accessor :series_title

  before_save :save_series_title, if: ->(o){ o.series_id.blank? && o.series_title }
  
  def save_series_title
    # Need to manually save since the autosave callbacks have already been called.
    self.series_id = user.series.find_or_create_by_title(series_title).try(:id)
  end
end
