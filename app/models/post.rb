class Post < ActiveRecord::Base
  validates :topic, presence: true, length: { minimum: 5 }
  validates :content, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_categoryships
  has_many :categories, through: :post_categoryships
end
