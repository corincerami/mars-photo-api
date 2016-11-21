class PhotoManifest
  include ActiveModel::Serialization

  attr_reader :rover

  delegate :name, :landing_date, :launch_date, :status, :max_sol, :max_date, :total_photos, to: :rover

  def initialize(rover)
    @rover = rover
  end

  def to_a
    rover.photos.joins(:camera).group(:sol)
      .select('sol, count(photos.id) AS cnt, ARRAY_AGG(DISTINCT cameras.name) AS cameras')
      .map { |photos| {sol: photos.sol, total_photos: photos.cnt, cameras: photos.cameras} }
  end

  def photos
    if $redis.get(cache_key_name).present?
      JSON.parse($redis.get cache_key_name)
    else
      cache
    end
  end

  def cache
    result = to_a
    $redis.set cache_key_name, result.to_json
    set_redis_expiration
    result
  end

  private

  def cache_key_name
    "#{rover.name.downcase}-manifest"
  end

  def set_redis_expiration
    if rover.active?
      $redis.expire cache_key_name, 1.day
    end
  end
end
