require 'rails_helper'

describe Api::V1::PhotosController do
  let(:rover) { create(:rover) }
  let(:camera) { create(:camera, rover: rover) }
  let!(:photo) { create(:photo, rover: rover, camera: camera) }

  describe "GET 'index'" do
    context "with no query parameters" do
      before(:each) do
        get :index, params: { rover_id: rover.name.downcase }
      end

      it "retrns an empty collection" do
        expect(json["photos"]).to be_empty
      end
    end

    context "with sol query" do
      before(:each) do
        get :index, params: { rover_id: rover.name, sol: 829 }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders photo data matching sol" do
        expect(json["photos"].length).to eq 1
        expect(json["photos"].first["sol"]).to eq photo.sol
      end
    end

    context "with sol query" do
      before(:each) do
        create_list(:photo, 25, rover: rover)
        get :index, params: { rover_id: rover.name, sol: 829 }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end
    end

    context "with sol and camera query" do
      before(:each) do
        get :index, params: { rover_id: rover.name, sol: 829, camera: camera.name }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders photo data matching sol and camera" do
        expect(json["photos"].length).to eq 1
        expect(json["photos"].first["camera"]["name"]).to eq camera.name
      end
    end

    context "with Earth date query" do
      before(:each) do
        get :index, params: { rover_id: rover.name, earth_date: "2014-12-05" }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders photo data matching Earth date" do
        expect(json["photos"].length).to eq 1
        expect(json["photos"].first["earth_date"]).to eq "2014-12-05"
      end
    end

    context "with Earth date and camera query" do
      before(:each) do
        get :index, params: { rover_id: rover.name.downcase, earth_date: "2014-12-05", camera: camera.name }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders photo data matching sol and camera" do
        expect(json["photos"].length).to eq 1
        expect(json["photos"].first["camera"]["name"]).to eq camera.name
      end
    end
  end

  describe "GET 'show'" do
    context "for an existing photo" do
      before(:each) do
        get :show, params: { id: photo.id }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "returns the photo's json" do
        expect(json["photo"])
      end
    end
  end
end
