class RemoveColumnsFromProfiles < ActiveRecord::Migration

  def change
    remove_column :profiles, :gender
    remove_column :profiles, :age
    remove_column :profiles, :interest
  end
end