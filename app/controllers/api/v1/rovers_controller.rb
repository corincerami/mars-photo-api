class Api::V1::RoversController < ApplicationController
  def index
    @rovers = Rover.all
    render json: @rovers
  end
end
