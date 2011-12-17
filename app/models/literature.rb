class Literature < ActiveRecord::Base
  belongs_to :user
  default_scope order(:id.desc)
  
  scope :recent, ->(number=5){ limit(number) }
  scope :visible, where(:deleted.not_eq => true)

  validates_presence_of :title
  validates_presence_of :contents
  validates_presence_of :user_id
  
  def visible?
  	!deleted
  end
end
