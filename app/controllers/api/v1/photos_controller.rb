class Api::V1::PhotosController < ApplicationController
  def show
    @photo = Photo.find(params[:id])
    render json: @photo
  end

  def index
    @photos = Photo.search(params[:sol], params[:camera])
    render json: @photos
  end
end
