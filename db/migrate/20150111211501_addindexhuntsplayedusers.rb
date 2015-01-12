class Addindexhuntsplayedusers < ActiveRecord::Migration
  def change
     add_index :huntsplayedusers, [:hunt_id, :question_no, :user_session_id],
     unique: true, name: 'byhuntquestionuser'
  end
end
