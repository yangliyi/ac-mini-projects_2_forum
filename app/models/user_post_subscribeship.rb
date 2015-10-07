class UserPostSubscribeship < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: :subscribed_users_count
end
