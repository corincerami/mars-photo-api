require 'rails_helper'

describe Api::V1::RoversController do
  describe "GET 'index'" do

    context "with no query parameters" do

      before(:each) do
        @rover = FactoryGirl.create(:rover)
        get :index
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders rovers json" do
        expect(json["rovers"].length).to eq 1
      end
    end
  end

  describe "GET 'show'" do
    context "with a valid rover name" do
      before(:each) do
        @rover = FactoryGirl.create(:rover)
        get :show, { id: @rover.name }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders the proper rover json" do
        expect(json["rover"]["name"]).to eq @rover.name
      end
    end

    context "with an invalid rover name" do
      before(:each) do
        @rover = FactoryGirl.create(:rover)
        get :show, { id: "Rover" }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 400
      end

      it "renders the proper rover json" do
        expect(json["errors"]).to eq "Invalid Rover Name"
      end
    end
  end
end
