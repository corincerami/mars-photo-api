require 'rails_helper'

describe Api::V1::LatestPhotosController do
  let(:rover) { create(:rover) }
  let(:camera) { create(:camera, rover: rover) }
  let!(:photo) { create(:photo, rover: rover, camera: camera) }

  suffix_hash = {
    'Curiosity' => {
      'small' => '-thm.jpg',
      'medium' => '-br.jpg',
      'large' => '.JPG'
    },
    'Spirit' => {
      'small' => '-THM.JPG',
      'medium' => '-BR.JPG',
      'large' => '.JPG'
    },
    'Opportunity' => {
      'small' => '-THM.JPG',
      'medium' => '-BR.JPG',
      'large' => '.JPG'
    },
    'Perseverance' => {
      'small' => '_320.jpg',
      'medium' => '_800.jpg',
      'large' => '_1200.jpg',
      'full' => '.png'
    }
  }

  describe "GET 'index'" do
    let!(:latest_photo) { create(:photo, rover: rover, camera: camera) }
    before(:each) do
      latest_photo.update(sol: 999)
    end

    context "with rover_id" do
      before(:each) do
        get :index, params: { rover_id: rover.name.downcase }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders photo data from most recent sol" do
        expect(json["latest_photos"].first["sol"]).to eq 999
      end
    end

    context "with bad Rover name" do
      before(:each) do
        get :index, params: { rover_id: "this doesn't exist"}
      end

      it "returns http 400 bad request" do
        expect(response.status).to eq 400
      end

      it "returns an error message" do
        expect(json["errors"]).to eq "Invalid Rover Name"
      end
    end

    context "with camera query" do
      before(:each) do
        create_list(:photo, 3, rover: rover, camera: create(:camera, {name: 'TEST', rover: rover}), sol: 9999)
        get :index, params: { rover_id: rover.name, camera: 'TEST' }
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it "renders photo data matching sol and camera" do
        expect(json["latest_photos"].length).to eq 3
        expect(json["latest_photos"].first["camera"]["name"]).to eq 'TEST'
      end
    end

    context "with pagination" do
      let(:params) { {rover_id: rover.name.downcase} }

      before(:each) do
        create_list(:photo, 35, rover: rover, camera: camera, sol: 9999)
      end

      it "returns 25 entries per page when a page param is provided" do
        get :index, params: params.merge(page: 1)

        expect(json["latest_photos"].length).to eq 25
      end

      it "returns all entries when no page param is provided" do
        get :index, params: params

        expect(json["latest_photos"].length).to eq 35
      end

      it "returns n entries per page when a per_page param is provided" do
        get :index, params: params.merge(page: 1, per_page: 30)

        expect(json["latest_photos"].length).to eq 30
      end

      it "returns the remaining entries on the last page of results" do
        get :index, params: params.merge(page: 2, per_page: 30)

        expect(json["latest_photos"].length).to eq 5
      end
    end

    suffix_hash.each do |rover_id, sizes|
      context "with rover_id '#{rover_id}'" do
        before(:each) do
          rover.update(name: rover_id)
        end

        sizes.each do |size, suffix|
          context "and size '#{size}'" do
            before(:each) do
              get :index, params: { rover_id: rover_id, size: size }
            end

            it "modifies img_src" do
              photo = json['latest_photos'].first
              expect(photo['img_src']).to end_with suffix
            end
          end
        end

        context "with invalid size parameter" do
          before(:each) do
            get :index, params: { rover_id: rover_id, size: "not a size" }
          end

          it "returns http 400 bad request" do
            expect(response.status).to eq 400
          end

          it "returns an error message" do
            expect(json["errors"]).to eq "Invalid size parameter 'not a size' for #{rover_id}"
          end
        end
      end
    end
  end
end
