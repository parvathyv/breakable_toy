class Addindexhuntsplayed < ActiveRecord::Migration
  def change
    add_index :huntsplayedusers, [:user_session_id, :hunt_id], unique: true
  end
end
