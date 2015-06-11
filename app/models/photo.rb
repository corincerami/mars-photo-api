class Photo < ActiveRecord::Base
  after_create :set_earth_date

  validates :img_src, uniqueness: true

  LANDING_DATE = Date.new(2012, 8, 6)
  SOL_IN_SECONDS = 88775.244

  def self.search(params)
    photos = search_by_date(params)
    if params[:camera]
      photos = photos.search_by_camera(params)
    end
    photos
  end

  def self.search_by_date(params)
    if params[:sol]
      photos = where(sol: params[:sol])
    elsif params[:earth_date]
      photos = where(earth_date: Date.strptime(params[:earth_date]))
    else
      photos = all
    end
    photos
  end

  def self.search_by_camera(params)
    where(camera: params[:camera].upcase)
  end

  def formatted_earth_date
    earth_date.strftime("%b %e, %Y")
  end

  def calculate_earth_date
    # numbers of martian rotations since landing converted to earth rotations
    LANDING_DATE + (sol.to_i * SOL_IN_SECONDS).seconds / 86400
  end

  def set_earth_date
    update(earth_date: calculate_earth_date)
  end
end
