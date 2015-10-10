class CreateTaipeiParks < ActiveRecord::Migration
  def change
    create_table :taipei_parks do |t|
      t.integer :park_id
      t.string :name
      t.string :administrativearea
      t.string :location

      t.timestamps null: false
    end
  end
end
