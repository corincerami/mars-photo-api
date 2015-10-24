class FixNavcamNullCameraIdsForCuriosityPhotos < ActiveRecord::Migration
  def up
    curiosity = Rover.find_by(name: "Curiosity")
    navcam = curiosity.cameras.find_by(name: "NAVCAM")

    photos = curiosity.photos.where(camera: nil)
    photos.update_all(camera_id: navcam.id)
  end

  def down
  end
end
