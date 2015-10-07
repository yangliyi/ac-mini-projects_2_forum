class Post < ActiveRecord::Base
  validates :topic, presence: true, length: { minimum: 5 }
  validates :content, presence: true

  belongs_to :user
  # Favorited by users
  has_many :favorite_posts
  has_many :favorited_by, through: :favorite_posts, source: :user # favorite_users
  # Liked by users
  has_many :user_post_likeships
  has_many :liked_users, through: :user_post_likeships, source: :user
  # Subscribed by users
  has_many :user_post_subscribeships
  has_many :subscribed_users, through: :user_post_subscribeships, source: :user

  has_many :taggings
  has_many :tags, through: :taggings

  has_many :comments, dependent: :destroy
  has_many :post_categoryships
  has_many :categories, through: :post_categoryships

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def published?
    status == "published"
  end

  def comment_users
    comments.map{ |c| c.user }.uniq
  end

  def last_comment
    comments.last
  end

  def tag_list
     self.tags.map{ |t| t.name }.join(",")
  end

  def tag_list=(str)
    arr = str.split(",")

    self.tags = arr.map do |t|
      tag = Tag.find_by_name(t)
      unless tag
        tag = Tag.create!( :name => t )
      end
      tag
    end

  end

end
