class CreateProfiles < ActiveRecord::Migration

  def change
    create_table :profiles do |t|
      t.string "gender"
      t.integer "age"
      t.string "interest"
      t.text "bio"
      t.integer "user_id"
    end

    add_index :profiles, :user_id
  end
end
