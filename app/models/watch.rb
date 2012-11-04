class Watch < ActiveRecord::Base
  attr_accessible :watchable_type, :watchable_id, :watchable
  belongs_to :user
  belongs_to :watchable, polymorphic: true
  
  scope :sorted, order(:id.desc)
  
  validates :user_id, :watchable_type, :watchable_id, :presence => true
end
