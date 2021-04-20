class Api::V1::LatestPhotosController < ApplicationController
  def index
    rover = Rover.find_by name: params[:rover_id].titleize

    if rover
      validated_params = params
        .permit(:rover_id, :camera, :earth_date, :size, :page, :per_page)
        .merge(sol: rover.photos.maximum(:sol))
      photos = rover.photos.search validated_params, rover

      begin
        photos = helpers.resize_photos photos, validated_params
        render json: photos, each_serializer: PhotoSerializer, root: :latest_photos
      rescue StandardError => e
        render json: { errors: e.inspect }, status: :bad_request
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
