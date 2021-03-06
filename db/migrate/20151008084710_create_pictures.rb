class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image
      t.attachment :image
      t.integer :post_id

      t.timestamps null: false
    end

    add_index :pictures, :post_id
  end
end
