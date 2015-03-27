class Photo < ActiveRecord::Base
  validates :img_src, uniqueness: true

  def self.search(sol, camera)
    where(sol: sol, camera: camera)
  end
end
