class Api::V1::PhotosController < ApplicationController
  before_action :photo_params

  def show
    photo = Photo.find photo_params[:id]
    photo = helpers.resize_photo photo, photo_params

    if photo != 'size error'
      render json: photo, serializer: PhotoSerializer, root: :photo
    else
      render json: {
        errors: "Invalid size parameter '#{photo_params[:size]}' for #{photo.rover.name.titleize} photo"
      }, status: :bad_request
    end
  end

  def index
    rover = Rover.find_by name: params[:rover_id].titleize

    if rover
      photos = helpers.search_photos rover, photo_params
      photos = helpers.resize_photos photos, photo_params

      if photos != 'size error'
        render json: photos, each_serializer: PhotoSerializer, root: :photos
      else
        render json: {
          errors: "Invalid size parameter '#{photo_params[:size]}' for #{rover.name.titleize} photos"
        }, status: :bad_request
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
