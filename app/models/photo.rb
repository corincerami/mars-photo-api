class Photo < ActiveRecord::Base
  def self.search(sol, camera)
    where(sol: sol, camera: camera)
  end
end
