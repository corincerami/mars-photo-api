class AddCameraIdToPhotos < ActiveRecord::Migration[4.2]
  def change
    add_column :photos, :camera_id, :integer
  end
end
