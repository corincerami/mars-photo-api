class Api::V1::LatestPhotosController < ApplicationController
  include PhotoHelper

  def index
    @rover = Rover.find_by name: params[:rover_id].titleize
    if @rover
      photos = search_photos(@rover)
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
    params.permit(:camera, :earth_date, :rover_id).merge(sol: @rover.photos.maximum(:sol))
  end

  def search_photos rover
    photos = rover.photos.order(:camera_id, :id).search photo_params, rover
    if params[:page]
      photos = photos.page(params[:page]).per params[:per_page]
    end

    photos
  end
end
