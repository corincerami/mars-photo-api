class PhotosController < ApplicationController
  def show
    @photo = Photo.find(params[:id])
  end

  def index
    @photos = Photo.search(params[:sol], params[:camera])
    respond_to do |format|
      format.html { @photos }
      format.json { render json: @photos }
    end
  end
end
