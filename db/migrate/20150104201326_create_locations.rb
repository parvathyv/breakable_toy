class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.timestamps
    end
    add_index :locations, [:latitude, :longitude], unique: true
  end
end
