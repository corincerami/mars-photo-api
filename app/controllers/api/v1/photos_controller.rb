class Api::V1::PhotosController < ApplicationController
  def show
    @photo = Photo.find(params[:id])
    render json: @photo
  end

  def index
    @photos = Photo.search(photo_params, params[:rover_id])
    render json: @photos
  end

  private

  def photo_params
    params.permit(:sol, :camera, :earth_date)
  end
end
