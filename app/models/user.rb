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

  def admin?
    self.role == "admin"
  end
end
