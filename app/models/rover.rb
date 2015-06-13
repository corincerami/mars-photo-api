class Rover < ActiveRecord::Base
  has_many :photos

  def to_param
    name.parameterize
  end
end
