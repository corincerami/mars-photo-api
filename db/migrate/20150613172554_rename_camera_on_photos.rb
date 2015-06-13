class RenameCameraOnPhotos < ActiveRecord::Migration
  def change
    rename_column :photos, :camera, :old_camera
  end
end
