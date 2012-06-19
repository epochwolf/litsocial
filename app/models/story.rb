class Story < ActiveRecord::Base
  has_many :comments, :as => :commentable, :conditions => {:parent_id => nil}, :order => :id.asc
  belongs_to :user
  belongs_to :series
  has_and_belongs_to_many :categories
  default_scope order(:id.desc)
  acts_as_list scope: :series, order: :series_position

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
  
  attr_accessible :title, :contents
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
end
