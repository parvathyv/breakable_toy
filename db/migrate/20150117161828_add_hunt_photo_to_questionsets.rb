class AddHuntPhotoToQuestionsets < ActiveRecord::Migration
  def change
    add_column :questionsets, :hunt_photo, :string
  end
end
