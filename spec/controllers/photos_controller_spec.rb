require 'rails_helper'

describe Api::V1::PhotosController do
  describe "GET 'index'" do

    context "with no query parameters" do

      before(:each) do
        @rover = FactoryGirl.create(:rover)
        get :index, { rover_id: @rover.name.downcase }
      end

      it "returns http 400 bad request" do
        expect(response.status).to eq 400
      end

      it "renders error json" do
        expect(response.body).to eq({ errors: "No Photos Found" }.to_json)
      end
    end

    context "with sol query" do
      before(:each) do
        @rover = FactoryGirl.create(:rover)
        @camera = FactoryGirl.create(:camera)
        @photo = FactoryGirl.create(:photo, rover: @rover)
        get :index, { rover_id: @rover.name.downcase, sol: 829 }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders photo data matching sol" do
        expect(JSON.parse(response.body)["photos"].length).to eq 1
        expect(JSON.parse(response.body)["photos"].first["sol"]).to eq @photo.sol
      end
    end
  end
end
