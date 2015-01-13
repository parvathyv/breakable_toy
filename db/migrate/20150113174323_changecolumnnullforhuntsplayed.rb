class Changecolumnnullforhuntsplayed < ActiveRecord::Migration
 def up
    change_column :huntsplayedusers, :address, :string, :null => true
  end
  def down
  end
end
