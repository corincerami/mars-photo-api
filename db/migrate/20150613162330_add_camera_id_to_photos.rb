class AddCameraIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :camera_id, :integer
  end
end
