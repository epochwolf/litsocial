class Message < ActiveRecord::Base
  attr_accessible :to_name, :message, :read, :reported
  attr_accessible :reported, as: :admin

  belongs_to :to, class_name: 'User'
  belongs_to :from, class_name: 'User'

  scope :visible, where{ (reported == false) | (reported == nil) }
  scope :admin_visible, where{ reported == true }
  scope :unread, where{ (read == false) | (read == nil) }
  scope :read, where{ read == true }
  scope :sorted, order(:id.desc)

  validates :to, :from, :message, presence: true

  def to_name
    to.try(:name)
  end

  def to_name=(name)
    self.to = User.find_by_name(name)
  end
end
