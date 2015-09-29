class Post < ActiveRecord::Base
  validates :topic, presence: true, length: { minimum: 5 }
  validates :content, presence: true

  has_many :comments, dependent: :destroy
end
