require 'rails_helper'

describe Api::V1::SurprisesController do
  let(:rover) { create(:rover) }
  let(:camera) { create(:camera, rover: rover) }
  let!(:photo) { create(:photo, rover: rover, camera: camera) }

  describe "GET 'index'" do
    context "with no query parameters" do
      before(:each) do
        create_list :photo, 5
        get :index
      end

      it "returns a random set of photos with a default length of 1" do
        expect(json["photos"].length).to eq 1
      end
    end

    context "with sol query" do
      before(:each) do
        create_list :photo, 10, sol: 117
        create_list :photo, 10, sol: 102
        get :index, params: { sol: 117, count: 5 }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders photo data matching sol" do
        expect(json["photos"].length).to eq 5
        expect(json["photos"].map{ |ph| ph["sol"] }.uniq).to contain_exactly 117
      end
    end

    context "with sol and camera query" do
      before(:each) do
        create_list :photo, 5, sol: 131, camera: camera
        create_list :photo, 5, sol: 132, camera: camera
        create_list :photo, 5, sol: 131, camera: create(:camera, name: "Not the right one")
        get :index, params: { sol: 131, camera: camera.name, count: 3 }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders photo data matching sol and camera" do
        expect(json["photos"].length).to eq 3
        expect(json["photos"].map{|ph| ph["camera"]["name"] }.uniq).to contain_exactly camera.name
        expect(json["photos"].map{|ph| ph["sol"] }.uniq).to contain_exactly 131
      end
    end

    context "with Earth date query" do
      before(:each) do
        # earth_date is based on sol
        create_list :photo, 10, sol: 1000 # earth_date = 2015-05-30
        create_list :photo, 10, sol: 1500 # earth_date = 2016-10-25
        get :index, params: { earth_date: "2015-05-30", count: 4 }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders photo data matching Earth date" do
        expect(json["photos"].length).to eq 4
        expect(json["photos"].map{|ph| ph["earth_date"] }.uniq).to contain_exactly "2015-05-30"
      end
    end

    context "with Earth date and camera query" do
      before(:each) do
        create_list :photo, 5, sol: 1000, camera: camera
        create_list :photo, 5, sol: 1500, camera: camera
        create_list :photo, 5, sol: 1000, camera: create(:camera, name: "Not the right one")
        get :index, params: { earth_date: "2015-05-30", camera: camera.name }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders photo data matching sol and camera" do
        expect(json["photos"].length).to eq 1
        expect(json["photos"].map{|ph| ph["camera"]["name"] }.uniq).to contain_exactly camera.name
        expect(json["photos"].map{|ph| ph["earth_date"] }.uniq).to contain_exactly "2015-05-30"
      end
    end

    context "with sol, rover, and camera query" do
      before(:each) do
        spirit = create :rover, name: "Spirit"
        rhaz = create :camera, name: "RHAZ", rover: spirit
        create_list :photo, 5, rover: spirit, camera: rhaz, sol: 225 # the matching ones
        create_list :photo, 5, rover: create(:rover, name: "Opportunity"), camera: rhaz, sol: 225
        create_list :photo, 5, rover: spirit, camera: rhaz, sol: 220
        create_list :photo, 5, rover: spirit, camera: create(:camera, name: "PANCAM"), sol: 225
        get :index, params: { sol: 225, rover: spirit.name, camera: rhaz.name, count: 3 }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders photo data matching all parameters" do
        expect(json["photos"].length).to eq 3
        expect(json["photos"].map{|ph| ph["camera"]["name"] }.uniq).to contain_exactly "RHAZ"
        expect(json["photos"].map{|ph| ph["sol"] }.uniq).to contain_exactly 225
        expect(json["photos"].map{|ph| ph["rover"]["name"] }.uniq).to contain_exactly "Spirit"
      end
    end
  end
end
