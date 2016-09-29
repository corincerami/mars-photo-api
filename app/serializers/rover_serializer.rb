class RoverSerializer < ActiveModel::Serializer
  attributes :id, :name, :landing_date, :launch_date, :status, :max_sol, :max_date, :total_photos

  has_many :cameras
end
