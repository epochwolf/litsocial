class Series < ActiveRecord::Base
  attr_accessible :description, :title  
  has_paper_trail :only => [
    :title, :description,
    :deleted, :deleted_reason
  ]

  belongs_to :user
  has_many :stories, order: 'series_position'
end
