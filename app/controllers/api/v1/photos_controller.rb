class Api::V1::PhotosController < ApplicationController
  def show
    @photo = Photo.find(params[:id])
    render json: @photo
  end

  def index
    @rover = Rover.find_by(name: params[:rover_id].titleize)
    @photos = @rover.photos.search(photo_params, params[:rover_id])
    render json: @photos
  end

  private

  def photo_params
    params.permit(:sol, :camera, :earth_date)
  end
end
