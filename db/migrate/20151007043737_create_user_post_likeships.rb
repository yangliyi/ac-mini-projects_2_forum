class CreateUserPostLikeships < ActiveRecord::Migration
  def change
    create_table :user_post_likeships do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps null: false
    end

    add_column :posts, :liked_users_count, :integer, default: 0

    add_index :user_post_likeships, :user_id
    add_index :user_post_likeships, :post_id
  end
end
