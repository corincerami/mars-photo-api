class RoverSerializer < ActiveModel::Serializer
  attributes :name, :landing_date, :max_sol, :max_date

  has_many :cameras
end
