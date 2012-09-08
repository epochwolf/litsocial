class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :series
  has_many :stories

  NAME_REGEX = /([a-z][a-z0-9_]{2,12}[a-z0-9])/

  validates :name, uniqueness: true, format:{with: /\A#{NAME_REGEX}\Z/, on: :create}

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :tagline, :biography, :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :tagline, :biography, :email, :banned, :banned_reason, as: :admin


  def self.valid_name?(name)
    name =~ /\A#{NAME_REGEX}\Z/
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
end
