class Changenullcolumnhuntsplayedusers < ActiveRecord::Migration
  def up
    change_column :huntsplayedusers, :address, :string, :null => false
  end
  def down
  end
end
