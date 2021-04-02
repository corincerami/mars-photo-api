class Api::V1::LatestPhotosController < ApplicationController
  include PhotoHelper

  def index
    @rover = Rover.find_by name: params[:rover_id].titleize
    if @rover
      photos = search_photos @rover, photo_params
      error = resize_photos photos, params

      if error.nil?
        render json: photos, each_serializer: PhotoSerializer, root: :latest_photos
      else
        render json: { errors: error }, status: :bad_request
      end
    else
      render json: { errors: "Invalid Rover Name" }, status: :bad_request
    end
  end

  private

  def photo_params
    params.permit(:camera, :earth_date, :rover_id, :size).merge(sol: @rover.photos.maximum(:sol))
  end
end
