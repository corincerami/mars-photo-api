class Api::V1::RoversController < ApplicationController
  def index
    @rovers = Rover.all
    render json: @rovers
  end

  def show
    @rover = Rover.find_by(name: params[:id].capitalize)
    render json: @rover
  end
end
