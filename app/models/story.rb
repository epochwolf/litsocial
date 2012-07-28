class Story < ActiveRecord::Base
  has_many :comments, :as => :commentable, :conditions => {:parent_id => nil}, :order => :id.asc
  belongs_to :user
  belongs_to :series
  has_and_belongs_to_many :categories
  default_scope order(:id.desc)
  acts_as_list scope: :series, column: "series_position"

  attr_accessor :series_title

  has_paper_trail :only => [
    :title, :contents,
    :deleted, :deleted_reason
  ]
  
  scope :recent, ->(number=5){ limit(number) }
  scope :visible, where(:deleted.not_eq => true)
  scope :sorted, order(:id.desc)

  validates_presence_of :title
  validates_presence_of :contents
  validates_presence_of :user_id
  
  attr_accessible :title, :contents, :series_id, :series_title
  attr_protected :as => :admin

  
  def visible?
  	!deleted
  end


  protected
  # acts as list doesn't update stuff when the scope changes *shrug*
  before_update :fix_acts_as_list, if: :series_id_changed?
  
  def fix_acts_as_list
    if series_id
      bottom_position_in_list
    else
      self.series_position = nil
    end
  end

  before_save :save_series_title, if: ->(o){ o.series_id.nil? && o.series_title }

  def save_series_title
    self.series = user.series.find_or_initialize_by_title(series_title)
    self.series_title = nil
    # Need to manually save since the association saving callbacks have already been called.
    self.series.save
  end
end
