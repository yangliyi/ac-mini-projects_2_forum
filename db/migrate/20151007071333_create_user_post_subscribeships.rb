class CreateUserPostSubscribeships < ActiveRecord::Migration
  def change
    create_table :user_post_subscribeships do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps null: false
    end

    add_column :posts, :subscribed_users_count, :integer, default: 0

    add_index :user_post_subscribeships, :user_id
    add_index :user_post_subscribeships, :post_id
  end
end
