class Changeindexhunts < ActiveRecord::Migration
  def up
    remove_index :huntsplayedusers, name: :byhuntquestionuser
  end
  def down
  end
end
