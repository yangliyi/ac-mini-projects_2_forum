class UserPostLikeship < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: :liked_users_count
end
