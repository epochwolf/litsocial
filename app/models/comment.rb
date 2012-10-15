class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  has_paper_trail

  # List all classes that allow comments. This is used for both validation and filtering in the controller. 
  COMMENTABLES = ["Story", "ForumPost", "NewsPost"]
  
  acts_as_list :scope => :parent
  belongs_to :parent, :class_name => "Comment"
  has_many :children, :class_name => "Comment", :foreign_key => 'parent_id', :order => 'position ASC'

  scope :top_levels, where(:parent_id => nil)
  scope :sorted, order(:id.asc)
  
  before_save :prevent_save_if_parent_is_reply
  before_update :set_edited, unless: :edited?
  
  validates :contents, :commentable_type, :commentable_id, :user_id, :presence => true
  validates_inclusion_of :commentable_type, :in => COMMENTABLES
  
  attr_accessible :parent_id, :contents
  attr_protected :as => :admin

  def parent_id=(int)
    self[:parent_id] = int if new_record?
  end
  
  def reply?
    parent_id ? true : false
  end
  
  def children?
    (reply_count || 0) > 0
  end
  
  protected
  def set_edited
    self.edited = true if contents_changed?
  end

  def prevent_save_if_parent_is_reply
    parent.try(:parent_id) ? false : true # returning false aborts the save.
  end
end