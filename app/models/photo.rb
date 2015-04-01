class Photo < ActiveRecord::Base
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

  def earth_date
    date = LANDING_DATE + (sol.to_i * SOL_IN_SECONDS).seconds
    date.strftime("%b %e, %Y")
  end
end
