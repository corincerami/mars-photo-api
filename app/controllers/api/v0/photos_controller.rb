module Api
  module V0
    class PhotosController < ApplicationController
      def show
        @photo = Photo.find params[:id]
        render json: @photo
      end

      def index
        @rover = Rover.find_by name: params[:rover_id].titleize
        @photos = @rover.photos.search photo_params, params[:rover_id]
        if @photos.any?
          render json: @photos.page(params[:page])
        else
          render json: { errors: "No Photos Found" }, status: :bad_request
        end
      end

      private

      def photo_params
        params.permit :sol, :camera, :earth_date
      end
    end
  end
end
