class PhotosController < ApplicationController
  def show
    @photo = Photo.find(params[:id])
  end

  def index
    @photos = Photo.search(params[:sol], params[:camera])
  end
end
