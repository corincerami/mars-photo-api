class RoversController < ApplicationController
  def index
    @curiosity = Rover.find_by(name: "Curiosity")
    @opportunity = Rover.find_by(name: "Opportunity")
    @spirit = Rover.find_by(name: "Spirit")
  end
end
