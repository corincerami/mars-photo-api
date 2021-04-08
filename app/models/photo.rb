class Photo < ActiveRecord::Base
  belongs_to :rover
  belongs_to :camera

  after_create :set_earth_date

  validates :img_src, uniqueness: true

  SECONDS_PER_SOL = 88775.244
  SECONDS_PER_DAY = 86400

  def self.search(params, rover)
    photos = search_by_date params

    if params[:camera]
      if photos.any?
        photos = photos.search_by_camera params, rover
      end
    end

    photos = photos.order(:camera_id, :id)

    if params[:page]
      photos = photos.page(params[:page]).per params[:per_page]
    end

    photos
  end

  def self.search_by_date(params)
    if params[:sol]
      where sol: params[:sol]
    elsif params[:earth_date]
      where earth_date: Date.strptime(params[:earth_date])
    else
      none
    end
  end

  def self.search_by_camera(params, rover)
    camera = rover.cameras.find_by name: params[:camera].upcase
    where camera: camera
  end

  def log
    Rails.logger.info "Photo with id #{id} created from #{rover.name}"
    Rails.logger.info "img_src: #{img_src}, sol: #{sol}, camera: #{camera}"
  end

  def log_and_save_if_new
    if new_record?
      log
      save
    end
  end

  private

  def set_earth_date
    update earth_date: calculate_earth_date
  end

  def calculate_earth_date
    rover.landing_date + earth_days_since_landing
  end

  def earth_days_since_landing
    sol.to_i * SECONDS_PER_SOL / SECONDS_PER_DAY
  end
end
