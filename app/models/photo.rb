class Photo < ActiveRecord::Base
  validates :img_src, uniqueness: true

  def self.search(sol, camera)
    if sol && camera
      where(sol: sol, camera: camera)
    elsif sol
      where(sol: sol)
    end
  end
end
