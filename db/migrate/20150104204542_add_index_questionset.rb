class AddIndexQuestionset < ActiveRecord::Migration
  def change
    add_index :questionsets, [:hunt_id, :question_no], unique: true
  end
end
