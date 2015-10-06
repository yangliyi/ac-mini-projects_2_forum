class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include Gravtastic
  gravtastic :secure => true,
              :filetype => :gif,
              :size => 50

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  validates :username, presence: true

  has_one :profile
  has_many :posts
  has_many :comments

  # Favorite posts of user
  has_many :favorite_posts
  has_many :favorites, through: :favorite_posts, source: :post

  def favorite_post?(post)
    self.favorites.include?(post)
  end

  def self.fb_email(fb_token)
    require "open-uri"
    raw_data = URI.parse("https://graph.facebook.com/v2.4/me?fields=email&access_token=#{fb_token}").read
    data = JSON.parse(raw_data)
    data["email"]
  end

  def self.from_omniauth(auth)
     # Case 1: Find existing user by facebook uid
     user = User.find_by_fb_uid( auth.uid )
     if user
        user.fb_token = auth.credentials.token
     #   user.fb_raw_data = auth
        user.save!
       return user
     end

     # Case 2: Find existing user by email
     existing_user = User.find_by_email( auth.info.email || fb_email(auth.credentials.token) )
     if existing_user
       existing_user.fb_uid = auth.uid
       existing_user.fb_token = auth.credentials.token
       #existing_user.fb_raw_data = auth
       existing_user.save!
       return existing_user
     end

     # Case 3: Create new password
     user = User.new
     user.fb_uid = auth.uid
     user.fb_token = auth.credentials.token
     user.email = auth.info.email || fb_email(auth.credentials.token)
     user.username = auth.info.name
     user.password = Devise.friendly_token[0,20]
     #user.fb_raw_data = auth
     user.save!
    return user
  end

  def admin?
    self.role == "admin"
  end

end
