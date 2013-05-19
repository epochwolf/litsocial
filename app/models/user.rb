class User < ActiveRecord::Base
  has_paper_trail only: [:name, :tagline, :biography, :email, :banned, :banned_reason, :admin]
  attr_accessible :name, :tagline, :biography, :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :tagline, :biography, :email, :banned, :banned_reason, as: :admin

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :admins, where{ admin == true }
  scope :members, where{ (banned_at == nil) & ((admin == false) | (admin == nil)) }
  scope :banned, where{ banned_at != nil }
  scope :sorted, order(:id.desc)

  has_many :series
  has_many :stories
  has_many :journals
  has_many :news_posts
  has_many :pages
  has_many :forum_posts
  has_many :messages, foreign_key: 'to_id'
  has_many :sent_messages, class_name: 'Message', foreign_key: 'from_id'
  has_many :favs
  has_many :bookmarks
  has_many :reports
  has_many :notifications
    # This is a list of things I have watched.
  has_many :watches

  # People this user is watching
  def watching
    User.joins("join watches on watches.watchable_type = 'User' and watches.watchable_id = users.id").where(watches: {user_id: id})
  end

  # People watching this user
  def watchers
    User.joins(:watches).where(watches:{watchable_type: 'User', watchable_id: id})
  end

  def bookmarked_stories
    Story.select(
      'stories.*, bookmarks.paragraph as bookmark_paragraph, bookmarks.updated_at as bookmark_updated_at'
    ).joins(:bookmarks).where(:bookmarks => {:user_id => self}).order("bookmarks.updated_at desc")
  end

  def bookmark_for(story)
    Bookmark.for(story, self)
  end

  NAME_REGEX = /([a-z][a-z0-9_]{2,12}[a-z0-9])/

  validates :name, uniqueness: true, format:{with: /\A#{NAME_REGEX}\Z/, on: :create}

  def gravatar_url(size=32)
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def title
    name
  end

  def self.valid_name?(name)
    name =~ /\A#{NAME_REGEX}\Z/
  end

  def watching?(object)
    return nil unless object
    watches.where(:watchable_type => object.class.name, :watchable_id => object.id).first
  end


  def faving?(object)
    return nil unless object
    favs.where(:favable_type => object.class.name, :favable_id => object.id).first
  end

  def reporting?(object)
    return nil unless object
    reports.where(:reportable_type => object.class.name, :reportable_id => object.id).first
  end

  def banned?
    banned_at ? true : false
  end

  def banned
    banned?
  end

  def banned=(bool)
    if bool.to_i == 0
      self.banned_at = nil
    elsif !banned?
      self.banned_at = DateTime.now
    end
  end

  def ban!
    update_column :banned_at, DateTime.now
  end

  def to_s
    name
  end
end
