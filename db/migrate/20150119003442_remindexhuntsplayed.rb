class Remindexhuntsplayed < ActiveRecord::Migration
  def up
    remove_index :huntsplayedusers, name: :index_huntsplayedusers_on_user_session_id_and_hunt_id
  end
  def down
  end
end
