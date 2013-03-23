class Series < ActiveRecord::Base
  attr_accessible :title
  attr_protected :user_id, :created_at, :updated_at, as: :admin


  scope :visible, scoped
  scope :sorted, order(:id.desc)

  belongs_to :user
  has_many :stories, order: :series_position.asc
  accepts_nested_attributes_for :stories

  def watchers
    User.joins(:watches).where(watches:{watchable_type: 'Series', watchable_id: id})
  end

  validates :title, :user_id, presence: true

  # Returns the next and previous stories for a given story in this series. 
  def next_prev(story)
    if story.series_id == id
      [
        stories.visible.where(:series_position.gt => story.id).order(:id.desc).first,
        stories.visible.where(:series_position.lt => story.id).order(:id.desc).first
      ]
    else
      []
    end
  end

  def visible?
    true
  end
end
