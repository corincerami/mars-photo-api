class AddRoverIdToPhotos < ActiveRecord::Migration[4.2]
  def change
    add_column :photos, :rover_id, :integer
  end
end
