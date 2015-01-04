class CreateQuestionset < ActiveRecord::Migration
  def change
    create_table :questionsets do |t|
      t.integer  "hunt_id",     null: false
      t.string   "question",    null: false
      t.integer  "question_no", null: false
      t.string   "address",     null: false
      t.float    "latitude",    null: false
      t.float    "longitude",   null: false
      t.timestamps
    end
  end
end
