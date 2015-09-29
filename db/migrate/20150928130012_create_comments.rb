class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :comment
      t.references :post, index: true

      t.timestamps null: false
    end
  end
end
