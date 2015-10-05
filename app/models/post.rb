class Post < ActiveRecord::Base
  validates :topic, presence: true, length: { minimum: 5 }
  validates :content, presence: true

  belongs_to :user
  # Favorited by users
  has_many :favorite_posts
  has_many :favorited_by, through: :favorite_posts, source: :user

  has_many :taggings
  has_many :tags, through: :taggings

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


  has_many :comments, dependent: :destroy
  has_many :post_categoryships
  has_many :categories, through: :post_categoryships

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
