class Story < ActiveRecord::Base
  has_many :comments, :as => :commentable, :conditions => {:parent_id => nil}, :order => :id.asc
  belongs_to :user
  default_scope order(:id.desc)
    
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
end
