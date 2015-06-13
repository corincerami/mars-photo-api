class RoversController < ApplicationController
  def index
    @rovers = Rover.all
  end
end
