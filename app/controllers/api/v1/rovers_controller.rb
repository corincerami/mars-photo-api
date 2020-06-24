class Api::V1::RoversController < ApplicationController
  def index
    rovers = Rover.all
    render json: rovers, each_serializer: RoverSerializer, root: :rovers
  end

  def show
    rover = Rover.find_by name: params[:id].capitalize
    if rover.present?
      render json: rover, serializer: RoverSerializer, root: :rover
    else
      render json: { errors: "Invalid Rover Name" }, status: :bad_request
    end
  end
end
