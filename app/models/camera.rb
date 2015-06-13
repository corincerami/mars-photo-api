class Camera < ActiveRecord::Base
  belongs_to :rover
  has_many :photos
end
