class RoverSerializer < ActiveModel::Serializer
  attributes :id, :name, :landing_date, :max_sol, :max_date, :total_photos

  has_many :cameras
end
