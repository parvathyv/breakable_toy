class Dropcolumnnullforhuntsplayed < ActiveRecord::Migration
  def change
      remove_column :huntsplayedusers, :address, :string
  end
end
