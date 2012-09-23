class Story < ActiveRecord::Base
  attr_accessible :contents, :series_id, :series_position, :title
  attr_protected :user_id, :created_at, :updated_at, as: :admin

  acts_as_list column: :series_position, scope: :series
  include Mixins::Lockable

  scope :sorted, order(:id.desc)
  scope :visible, where{ (deleted != true) & (locked_at == nil) }

  belongs_to :series, counter_cache: true
  belongs_to :user

  validates :title, :contents, :user_id, presence: true
  validates :locked_reason, presence: true, if: :locked?
  validate :series_belongs_to_same_owner_as_story

  attr_accessor :series_title
  before_save :save_series_title, if: ->(o){ o.series_id.blank? && o.series_title }

  def visible?
    !(deleted? || locked?)
  end

  def series?
    series_id
  end

  protected
  def save_series_title
    # Need to manually save since the autosave callbacks have already been called.
    self.series_id = user.series.find_or_create_by_title(series_title).try(:id)
  end

  def series_belongs_to_same_owner_as_story
    series.reload if series_id_changed?
    errors.add :series_id, "Series must belong to the same user" unless series.nil? || series.user == user
  end

end
