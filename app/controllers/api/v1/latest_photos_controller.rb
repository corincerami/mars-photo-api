class Api::V1::LatestPhotosController < ApplicationController
  def index
    def index
      @rover = Rover.find_by name: params[:rover_id].titleize
      if @rover
        render json: search_photos, each_serializer: PhotoSerializer, root: :latest_photos
      else
        render json: { errors: "Invalid Rover Name" }, status: :bad_request
      end
    end
  end

  private

  def photo_params
    params.permit(:camera, :earth_date).merge(sol: @rover.photos.maximum(:sol))
  end

  def search_photos
    photos = @rover.photos.order(:camera_id, :id).search photo_params, @rover
    if params[:page]
      photos = photos.page(params[:page]).per params[:per_page]
    end
    photos
  end
end
