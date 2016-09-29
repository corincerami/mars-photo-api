class PhotoManifest
  include ActiveModel::Serialization

  attr_reader :rover

  delegate :name, :landing_date, :launch_date, :status, :max_sol, :max_date, :total_photos, to: :rover

  def initialize(rover)
    @rover = rover
  end

  def to_a
    rover.photos.includes(:camera).group_by(&:sol).map do |sol, photos|
      photos_by_sol(sol, photos)
    end
  end

  def photos
    to_a
  end

  private

  def photos_by_sol(sol, photos)
    {
      sol: sol,
      total_photos: photos.count,
      cameras: cameras_from_photos(photos)
    }
  end

  def cameras_from_photos(photos)
    photos.map { |photo| photo.camera.name }.uniq
  end
end
