class Profile < ActiveRecord::Base
  validates :bio, presence: true

  belongs_to :user
end
