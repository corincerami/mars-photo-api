class PhotoManifest
  attr_reader :rover

  def initialize(rover)
    @rover = rover
  end

  def to_a
    rover.photos.group_by(&:sol).map do |sol, photos|
      photos_by_sol(sol, photos)
    end
  end

  private

  def photos_by_sol(sol, photos)
    {
      sol: sol,
      total_photos: photos.count,
      cameras: photos_by_camera(photos)
    }
  end

  def photos_by_camera(photos)
    photos.group_by { |photo| photo.camera.name }.map do |camera, camera_photos|
      [camera, camera_photos.count]
    end.to_h
  end
end
