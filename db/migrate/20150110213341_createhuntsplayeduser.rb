class Createhuntsplayeduser < ActiveRecord::Migration
  def change
    create_table :huntsplayedusers do |t|
      t.integer :hunt_id, null: false
      t.integer :user_id, null: false
      t.integer :question_no, null: false
      t.string :user_session_id, null: false
      t.timestamps
    end
    add_index :huntsplayedusers, [:user_session_id, :hunt_id], unique: true
  end
end
