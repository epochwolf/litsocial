class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  acts_as_list :scope => :parent
  belongs_to :parent, :class_name => "Comment", :counter_cache => :reply_count
  has_many :children, :class_name => "Comment", :foreign_key => 'parent_id', :order => 'position ASC'
  # Possible optimization for later
  #REPLY_DISPLAY_LIMIT = 5
  #has_many :first_children, :class_name => "Comment", :foreign_key => 'parent_id', :order => 'position ASC', :conditions => {:position.lteq => REPLY_DISPLAY_LIMIT}
  #has_many :rest_of_children, :class_name => "Comment", :foreign_key => 'parent_id', :order => 'position ASC', :conditions => {:position.gt => REPLY_DISPLAY_LIMIT}

  scope :top_levels, where(:parent_id => nil)
  scope :sorted, order(:id.asc)
  
  before_save :prevent_save_if_parent_is_reply
  
  validates :contents, :commentable_type, :commentable_id, :user_id, :presence => true
  
  def children?
    reply_count > 0
  end
  
  protected
  def prevent_save_if_parent_is_reply
    parent.try(:parent_id) ? false : true
  end
end
