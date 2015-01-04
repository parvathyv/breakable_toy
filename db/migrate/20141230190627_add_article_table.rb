class AddArticleTable < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :description, null: false
      t.integer :vote_count, default: 0, null: false
      t.integer :user_id
      t.integer :category_id
      t.timestamps
    end
  end
end
