class Photo < ActiveRecord::Base
  after_create :set_earth_date

  validates :img_src, uniqueness: true

  LANDING_DATE = DateTime.new(2012,8,6,5,17,57)
  SOL_IN_SECONDS = 88775.244

  def self.search(sol, camera)
    if sol && camera
      where(sol: sol, camera: camera)
    elsif sol
      where(sol: sol)
    end
  end

  def formatted_earth_date
    self.earth_date.strftime("%b %e, %Y")
  end

  def calculate_earth_date
    LANDING_DATE + (sol.to_i * SOL_IN_SECONDS).seconds
  end

  def set_earth_date
    self.update(earth_date: self.calculate_earth_date)
  end
end
