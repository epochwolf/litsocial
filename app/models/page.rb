class Page < ActiveRecord::Base
  acts_as_tree
  belongs_to :user
  
  scope :visible, where(:published => true)
  scope :sorted, order(:title.desc)
  
  validates :title, :contents, :user_id, :presence => true
  validates_uniqueness_of :url, :allow_blank => true
  validates_format_of :url, :with => /^[a-z]/, :message => "Must start with a letter", :allow_blank => true

  def url=(str)
    self[:url] = self.class.clean_up_url(str)
  end
  
  
  def self.find_by_url_or_id!(id)
    if id =~ /^\d+$/
      find(id)
    else
      id = clean_up_url(id)
      find_by_url(id) or raise ActiveRecord::RecordNotFound, "Didn't find record by url: #{id}"
    end
  end
  
  def self.clean_up_url(url)
    url.strip.gsub(/\s+/, '-').gsub(%r{/+$}, '')
  end
end