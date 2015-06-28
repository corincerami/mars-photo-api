require 'rails_helper'

RSpec.describe Rover, type: :model do
  describe "attributes" do
    it { should respond_to :name }
    it { should respond_to :landing_date }
  end

  describe "associations" do
    it { should have_many :photos }
    it { should have_many :cameras }
  end

  describe ".to_param" do
    it "should parameterize the Rover's name" do
      @rover = FactoryGirl.create(:rover)

      expect(@rover.to_param).to eq "curiosity"
    end
  end

  describe ".max_sol" do
    it "should return the highest sol for the Rover's photos" do
      @photo = FactoryGirl.create(:photo)

      expect(@photo.rover.max_sol).to eq 829
    end
  end

  describe ".max_date" do
    it "should return the highest date for the Rover's photos" do
      @photo = FactoryGirl.create(:photo)

      expect(@photo.rover.max_date).to eq Date.new(2014, 12, 5)
    end
  end
end
