require 'rails_helper'

RSpec.describe Photo, type: :model do
  let(:rover) { create(:rover) }
  let(:camera) { create(:camera, rover: rover) }
  let(:photo) { create(:photo, camera: camera, rover: rover) }

  describe ".search" do
    context "with sol query" do
      it "returns matching photos" do
        params = { sol: 829, rover: photo.rover.name }

        expect(Photo.search(params, photo.rover)).to include photo
      end
    end

    context "with sol and camera query" do
      it "returns matching photos" do
        photo.camera.update(rover: photo.rover)
        params = { sol: 829, rover: photo.rover.name, camera: photo.camera.name }

        expect(Photo.search(params, photo.rover)).to include photo
      end
    end

    context "with Earth date query" do
      it "returns matching photos" do
        params = { earth_date: "2014-12-05" }

        expect(Photo.search(params, photo.rover)).to include photo
      end
    end

    context "with Earth date and camera query" do
      it "returns matching photos" do
        photo.camera.update(rover: photo.rover)
        params = { earth_date: "2014-12-05", camera: photo.camera.name }

        expect(Photo.search(params, photo.rover)).to include photo
      end
    end
  end

  describe "calculating Earth date" do
    let(:photo) { build(:photo, earth_date: nil) }

    it "happens on save" do
      expect {
        photo.save
      }.to change { photo.earth_date }
    end

    it "calculates the correct date" do
      photo.save

      expect(photo.earth_date.to_s).to eq Date.new(2014, 12, 5).to_s
    end
  end
end
