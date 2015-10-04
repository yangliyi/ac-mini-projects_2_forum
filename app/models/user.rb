class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include Gravtastic
  gravtastic :secure => true,
              :filetype => :gif,
              :size => 50

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true

  has_one :profile
  has_many :posts
  has_many :comments

  # Favorite posts of user
  has_many :favorite_posts
  has_many :favorites, through: :favorite_posts, source: :post
  def admin?
    self.role == "admin"
  end
end
