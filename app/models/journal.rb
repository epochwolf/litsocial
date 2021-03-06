class Journal < ActiveRecord::Base
  include Mixins::Taggable
  include Mixins::Lockable
  has_paper_trail
  belongs_to :user
  has_many :comments, :as => :commentable, :order => :id.asc

  scope :visible, where{ ((deleted == false) | (deleted == nil)) & (locked_at == nil) & ((draft == false) | (draft == nil)) }
  scope :owner_visible, where{ (deleted == false) | (deleted == nil) }

  scope :sorted, order(:id.desc)
  # Locked is a restricted name, used by AREL internally, see: https://github.com/rails/rails/issues/7421
  scope :is_locked, where{ locked_at == nil }
  scope :draft, where{ (draft == true) }
  scope :deleted, where{ deleted == true }

  attr_accessible :contents, :draft, :tag_list, :title
  attr_protected :user_id, :created_at, :updated_at, as: :admin

  validates :title, :contents, presence: true
  validates :locked_reason, presence: true, if: :locked?

   def visible?
    !(draft? || deleted? || locked?)
  end

  def next
    self.class.visible.where(:id.gt => id).reorder(:id.asc).first
  end

  def prev
    self.class.visible.where(:id.lt => id).reorder(:id.desc).first
  end
end
