class Page < ActiveRecord::Base
  has_paper_trail
  attr_accessible
  attr_protected as: :admin

  scope :visible, where(published: true)

  scope :draft, where{ (published == false) | (published == nil) }
  scope :sorted, order(:id.desc)

  belongs_to :user

  validates :title, :contents, :user_id, presence: true

  def self.find_by_id_or_url(id_or_url)
    field = id_or_url =~ /^\d+\/?$/ ? :id : :url
    where(field => id_or_url.to_s.chomp('/')).first
  end

  def url=(str)
    self[:url] = str.to_s.gsub(%r[/$], '')
  end

  def to_param
    url.presence || id
  end
end
