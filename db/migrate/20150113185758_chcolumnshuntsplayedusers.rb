class Chcolumnshuntsplayedusers < ActiveRecord::Migration
  def up
    change_column :huntsplayedusers, :address, :string, :null => false, default: 'None'
  end
  def down
  end
end
