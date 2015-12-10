module V0
  class RoverSerializer < ActiveModel::Serializer
    attributes :id, :name, :landing_date, :max_sol, :max_date, :total_photos

    def id
      name
    end

    has_many :cameras
  end
end
