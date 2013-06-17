class Story < ActiveRecord::Base
  include Mixins::Taggable
  has_paper_trail
  attr_accessible :contents, :series_id, :series_position, :title, :remove_from_series
  attr_protected :user_id, :created_at, :updated_at, as: :admin

  acts_as_list column: :series_position, scope: :series
  include Mixins::Lockable


  scope :visible, where{ ((deleted == false) | (deleted == nil))  & (locked_at == nil) }
  scope :owner_visible, where{ (deleted == false) | (deleted == nil) } # Postgres doesn't select nulls if deleted != true

  scope :sorted, order(:id.desc)
  # Locked is a restricted name, used by AREL internally, see: https://github.com/rails/rails/issues/7421
  scope :is_locked, where{ locked_at == nil }
  scope :deleted, where{ deleted == true }

  belongs_to :series, counter_cache: true
  belongs_to :user
  has_many :bookmarks
  has_many :comments, :as => :commentable, :order => :id.asc

  validates :title, :contents, :user_id, presence: true
  validates :locked_reason, presence: true, if: :locked?
  validates_numericality_of :series_position, :message => "is not a number", allow_blank: true
  validate :series_belongs_to_same_owner_as_story

  attr_accessor :series_title
  before_save :save_series_title, if: ->(o){ o.series_id.blank? && o.series_title }
  before_save :update_word_count, if: :contents_changed?
  before_create :fix_acts_as_list
  before_update :fix_acts_as_list, if: :series_id_changed?

  def safe_contents
    MyHtmlSanitizer.clean contents
  end

  def visible?
    !(deleted? || locked?)
  end

  def next
    return unless series?
    self.class.visible.where(series_id: series_id, :series_position.gt => series_position).reorder(:series_position.asc).first
  end

  def prev
    return unless series?
    self.class.visible.where(series_id: series_id, :series_position.lt => series_position).reorder(:series_position.desc).first
  end

  def series?
    series_id
  end

  def remove_from_series
    series_id.nil?
  end

  def remove_from_series=(bool)
    return unless bool.to_i == 1
    self.series_id = nil
  end

  protected  
  def update_word_count
    # TODO: Add paragraph counter
    # Possible implementation: Load contents into nokogiri to count the number of p nodes?
    self.word_count = HTML::FullSanitizer.new.sanitize(self.contents || "").scan(/\w+(-\w+)?/).length
    self.paragraph_count = Nokogiri::HTML(MyHtmlSanitizer.basic_cleansing(self.contents)).search("/html/body/p").count
  end

  def fix_acts_as_list
    if series_id
      self.series_position = bottom_position_in_list.to_i + 1
    else
      self.series_position = nil
    end
  end

  def save_series_title
    # Need to manually save since the autosave callbacks have already been called.
    self.series_id = user.series.find_or_create_by_title(series_title).try(:id)
  end

  def series_belongs_to_same_owner_as_story
    errors.add :series_id, "Series must belong to the same user" unless series.nil? || series.user == user
  end

end
