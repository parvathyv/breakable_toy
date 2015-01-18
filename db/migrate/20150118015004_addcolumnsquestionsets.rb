class Addcolumnsquestionsets < ActiveRecord::Migration
  def change
    add_column :questionsets, :description, :string
  end
end
