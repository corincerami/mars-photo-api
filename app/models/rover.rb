class Rover < ActiveRecord::Base
  has_many :photos
  has_many :cameras

  def to_param
    name.parameterize
  end
end
