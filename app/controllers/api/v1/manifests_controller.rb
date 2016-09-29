class Api::V1::ManifestsController < ApplicationController
  def show
    rover = Rover.find_by(name: params[:id].capitalize)
    if rover.present?
      @manifest = PhotoManifest.new(rover)
      render json: @manifest
    else
      render json: { errors: "Invalid Rover Name" }, status: :bad_request
    end
  end
end
