class CreateFavoritePosts < ActiveRecord::Migration
  def change
    create_table :favorite_posts do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps null: false
    end

    add_index :favorite_posts, :user_id
    add_index :favorite_posts, :post_id
  end
end
