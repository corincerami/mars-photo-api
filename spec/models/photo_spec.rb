require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe ".search" do
    context "with sol query" do
      it "returns matching photos" do
        @photo = FactoryGirl.create(:photo)
        params = { sol: 829, rover: @photo.rover.name }

        expect(Photo.search(params, @photo.rover.name)).to include @photo
      end
    end

    context "with sol and camera query" do
      it "returns matching photos" do
        @photo = FactoryGirl.create(:photo)
        @photo.camera.update(rover: @photo.rover)
        params = { sol: 829, rover: @photo.rover.name, camera: @photo.camera.name }

        expect(Photo.search(params, @photo.rover.name)).to include @photo
      end
    end

    context "with Earth date query" do
      it "returns matching photos" do
        @photo = FactoryGirl.create(:photo)
        params = { earth_date: "2014-12-05" }

        expect(Photo.search(params, @photo.rover.name)).to include @photo
      end
    end

    context "with Earth date and camera query" do
      it "returns matching photos" do
        @photo = FactoryGirl.create(:photo)
        @photo.camera.update(rover: @photo.rover)
        params = { earth_date: "2014-12-05", camera: @photo.camera.name }

        expect(Photo.search(params, @photo.rover.name)).to include @photo
      end
    end
  end

  describe ".formatted_earth_date" do
    it "should be formatted like 'Dec 5, 2014'" do
      @photo = FactoryGirl.create(:photo)
      expect(@photo.formatted_earth_date).to eq "Dec 5, 2014"
    end
  end
end
