class PhotosController < ApplicationController
  def show
    @photo = Photo.find(params[:id])
  end

  def index
    @rover = Rover.find_by(name: params[:rover_id].titleize)
    @photos = @rover.photos.search(photo_params, params[:rover_id])
  end

  private

  def photo_params
    params.permit(:sol, :camera, :earth_date)
  end
end
