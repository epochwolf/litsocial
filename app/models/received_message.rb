class ReceivedMessage < ActiveRecord::Base
  belongs_to :message
  belongs_to :to, :class_name => 'User'
  
  scope :visible, where(:deleted => false)
  scope :unread, where(:read => false)
  scope :read, where(:read => true)
  scope :sorted, order(:id.desc)
  
  delegate :from, :contents, :to => :message
  
  def js_id
    "message-" + (new_record? ? String.random : message_id.to_s)
  end
  
  attr_accessible :read, :flagged, :deleted
  
  before_save :copy_flagged_to_message
  
  def copy_flagged_to_message
    if flagged? && !message.flagged?
      message.update_attribute :flagged, true
    else 
      true
    end
  end
end