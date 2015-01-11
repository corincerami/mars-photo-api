class PhotosController < ApplicationController
  def show
    @photo = Photo.find(params[:id])
  end
end
