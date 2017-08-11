module Api
  module V0
    class RoversController < ApplicationController
      def index
        @rovers = Rover.all
        render json: @rovers, each_serializer: serializer
      end

      def show
        @rover = Rover.find_by name: params[:id].capitalize
        if !@rover.blank?
          render json: @rover, serializer: serializer
        else
          render json: { errors: "Invalid Rover Name" }, status: :bad_request
        end
      end

      private

      def serializer
        ::V0::RoverSerializer
      end
    end
  end
end
