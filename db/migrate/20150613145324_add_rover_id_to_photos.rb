class AddRoverIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :rover_id, :integer
  end
end
