class Api::V1::PhotosController < ApplicationController
  before_action :photo_params

  def show
    photo = Photo.find @params[:id]
    resized_photo = helpers.resize_photo photo, @params

    if resized_photo != 'size error'
      render json: resized_photo, serializer: PhotoSerializer, root: :photo
    else
      render json: {
        errors: "Invalid size parameter '#{@params[:size]}' for #{photo.rover.name.titleize}"
      }, status: :bad_request
    end
  end

  def index
    rover = Rover.find_by name: @params[:rover_id].titleize

    if rover
      photos = rover.photos.search @params, rover
      photos = helpers.resize_photos photos, @params

      if photos != 'size error'
        render json: photos, each_serializer: PhotoSerializer, root: :photos
      else
        render json: {
          errors: "Invalid size parameter '#{@params[:size]}' for #{@params[:rover_id].titleize}"
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
