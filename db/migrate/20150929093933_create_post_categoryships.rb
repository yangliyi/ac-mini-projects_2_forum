class CreatePostCategoryships < ActiveRecord::Migration
  def change
    create_table :post_categoryships do |t|
      t.integer :post_id
      t.integer :category_id

      t.timestamps null: false
    end

    add_index :post_categoryships, :post_id
    add_index :post_categoryships, :category_id

  end
end
