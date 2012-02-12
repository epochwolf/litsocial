class NewsPost < ActiveRecord::Base
  has_many :comments, :as => :commentable, :conditions => {:parent_id => nil}, :order => :id.asc
  belongs_to :user
  
  scope :visible, where(:published => true)
  scope :sorted, order(:id.desc)
  
  validates :title, :contents, :user_id, :presence => true
end
