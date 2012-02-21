class Message < ActiveRecord::Base
  has_many :received_messages
  has_many :to,   :class_name => "User", :through => :received_messages
  belongs_to :from, :class_name => "User"
  
  scope :sorted, order(:id.desc)
  
  
  validates_presence_of :to, :contents, :from
  
  def to_ids
    to.map(&:id).join(", ")
  end
  
  def to_ids=(arr)
    arr = arr.split "," if arr.is_a? String
    return if arr.blank?
    users = arr.map{|i| User.find_by_id(i) }
    self.to = users
  end
  
  attr_accessible :contents, :to_ids
  # Don't want admins message with messages
  attr_accessible :deleted, :deleted_reason, :as => :admin
end
