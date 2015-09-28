class Post < ActiveRecord::Base
  validates :topic, presence: true
  validates :content, presence: true
end
