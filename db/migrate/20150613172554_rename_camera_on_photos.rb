class RenameCameraOnPhotos < ActiveRecord::Migration[4.2]
  def change
    rename_column :photos, :camera, :old_camera
  end
end
