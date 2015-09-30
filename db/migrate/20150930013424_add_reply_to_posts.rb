class AddReplyToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer
    add_column :posts, :last_comment, :datetime
  end
end
