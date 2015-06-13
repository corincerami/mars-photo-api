class PhotosController < ApplicationController
  def show
    @photo = Photo.find(params[:id])
  end

  def index
    @rover = Rover.find(params[:rover_id])
    @photos = @rover.photos.search(photo_params)
  end

  private

  def photo_params
    params.permit(:sol, :camera, :earth_date)
  end
end
