class Addcolumnshuntsplayedusers < ActiveRecord::Migration
  def change
    add_column :huntsplayedusers, :address, :string
  end
end
