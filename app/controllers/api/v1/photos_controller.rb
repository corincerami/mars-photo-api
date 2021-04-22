class Api::V1::PhotosController < ApplicationController
  before_action :photo_params

  def show
    photo = Photo.find @params[:id]

    begin
      resized_photo = helpers.resize_photo photo, @params
      render json: resized_photo, serializer: PhotoSerializer, root: :photo
    rescue StandardError => e
      render json: { errors: e.message }, status: :bad_request
    end
  end

  def index
    rover = Rover.find_by name: @params[:rover_id].titleize

    if rover
      photos = rover.photos.search @params, rover

      begin
        photos = helpers.resize_photos photos, @params
        render json: photos, each_serializer: PhotoSerializer, root: :photos
      rescue PhotoHelper::InvalidSizeParameter => e
        render json: { errors: e.message }, status: :bad_request
      end
    else
      render json: { errors: "Invalid Rover Name" }, status: :bad_request
    end
  end

  private

  def photo_params
    @params = params.permit :id, :rover_id, :sol, :camera, :earth_date, :size, :page, :per_page
  end
end
