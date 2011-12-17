class User < ActiveRecord::Base
  serialize :facebook_data
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable
        
  has_many :literatures
        
  validates_inclusion_of :gender, :in => %w( male female ), :allow_blank => true
  validates_uniqueness_of :facebook_token, :allow_nil => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :biography, :password, :password_confirmation, :remember_me, :autopost_to_facebook, :sync_with_facebook
  
  def facebook?
    facebook_token ? true : false
  end
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info.to_hash
    data.symbolize_keys!
    puts data.inspect
    
    user = (
      User.find_by_facebook_token(data[:id]) || 
      User.find_by_email(data[:email]) || 
      User.new_for_facebook 
    )
    user.save if user.update_facebook_data(data)
    user
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.update_facebook_data(session["devise.facebook_data"])
      end
    end
  end
  
  def self.new_for_facebook
    password = Devise.friendly_token[0,20]
    u = User.new(:password => password, :password_confirmation => password)
    u.never_set_password = true
    u
  end
  
  def update_facebook_data(data)
    return false if facebook_token && !sync_with_facebook
    self.facebook_token     = data[:id]
    self.email              = data[:email] if self.email.blank?
    self.name               = data[:name]
    self.gender             = data[:gender]
    self.timezone           = data[:timezone]
    self.biography          = data[:bio]
    self.sync_with_facebook = true
    self.facebook_data      = data
    true
  end
end
