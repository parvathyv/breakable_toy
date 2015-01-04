class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :body, null: false
      t.integer :user_id, null: false
      t.integer :article_id, null: false
      t.timestamps
    end
  end
end
