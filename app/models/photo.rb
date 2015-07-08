class Photo < ActiveRecord::Base
  belongs_to :rover
  belongs_to :camera

  after_create :set_earth_date

  validates :img_src, uniqueness: true

  SOL_IN_SECONDS = 88775.244

  def self.search(params, rover)
    photos = search_by_date(params)
    if params[:camera]
      if photos.any?
        photos = photos.search_by_camera(params, rover)
      end
    end
    photos
  end

  def self.search_by_date(params)
    if params[:sol]
      photos = where(sol: params[:sol])
    elsif params[:earth_date]
      photos = where(earth_date: Date.strptime(params[:earth_date]))
    else
      photos = Photo.none
    end
    photos
  end

  def self.search_by_camera(params, rover)
    rover = Rover.find_by(name: rover.titleize)
    camera = rover.cameras.find_by(name: params[:camera].upcase)
    where(camera: camera)
  end

  def formatted_earth_date
    earth_date.strftime("%b%e, %Y")
  end

  def calculate_earth_date
    # numbers of martian rotations since landing converted to earth rotations
    rover.landing_date + (sol.to_i * SOL_IN_SECONDS).seconds / 86400
  end

  def set_earth_date
    update(earth_date: calculate_earth_date)
  end
end
