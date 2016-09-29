require 'rails_helper'

describe Api::V1::ManifestsController do
  describe "GET 'show'" do
    context "with a valid rover name" do
      before(:each) do
        @rover = create(:rover)
        @camera = create(:camera, rover: @rover)
        create(:photo, rover: @rover, sol: 1, camera: @camera)
        create(:photo, rover: @rover, sol: 30, camera: @camera)
        create(:photo, rover: @rover, sol: 100, camera: @camera)
        create(:photo, rover: @rover, sol: 100, camera: @camera)
        get :show, { id: @rover.name }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders the proper rover json" do
        expect(json["photo_manifest"]["name"]).to eq @rover.name
      end

      it "contains the mission's landing_date" do
        expect(json["photo_manifest"]["landing_date"]).to eq @rover.landing_date.to_s
      end

      it "contains the mission's launch_date" do
        expect(json["photo_manifest"]["launch_date"]).to eq @rover.launch_date.to_s
      end

      it "contains the mission's status" do
        expect(json["photo_manifest"]["status"]).to eq @rover.status
      end

      it "contains a record for each sol for which there are photos" do
        expect(json["photo_manifest"]["photos"]).to contain_exactly(
          {"sol" => 1, "total_photos" => 1, "cameras" => {"FHAZ" => 1}},
          {"sol" => 30, "total_photos" => 1, "cameras" => {"FHAZ" => 1}},
          {"sol" => 100, "total_photos" => 2, "cameras" => {"FHAZ" => 2}}
        )
      end
    end

    context "with an invalid rover name" do
      before(:each) do
        @rover = create(:rover)
        get :show, { id: "Rover" }
      end

      it "returns http 400 bad request" do
        expect(response.status).to eq 400
      end

      it "renders the proper rover json" do
        expect(json["errors"]).to eq "Invalid Rover Name"
      end
    end
  end
end
