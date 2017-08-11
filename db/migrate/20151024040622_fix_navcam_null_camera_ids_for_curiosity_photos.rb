class FixNavcamNullCameraIdsForCuriosityPhotos < ActiveRecord::Migration[4.2]
  class Rover < ActiveRecord::Base
    has_many :cameras
    has_many :photos
  end

  def up
    curiosity = Rover.find_by(name: "Curiosity")

    if curiosity
      navcam = curiosity.cameras.find_by(name: "NAVCAM")

      photos = curiosity.photos.where(camera: nil)
      photos.update_all(camera_id: navcam.id)
    end
  end

  def down
  end
end
