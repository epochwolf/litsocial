class Report < ActiveRecord::Base
  attr_accessible :reportable_type, :reportable_id, :reason

  scope :resolved, where(resolved: true)
  scope :not_resolved, where{ (resolved == false) | (resolved == nil) }
  scope :sorted, order(:id.desc)

  belongs_to :user
  belongs_to :reportable, polymorphic: true
  
  validates :user_id, :reportable_type, :reportable_id, :presence => true
end
