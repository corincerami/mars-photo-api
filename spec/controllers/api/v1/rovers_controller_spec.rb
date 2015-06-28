require 'rails_helper'

describe Api::V1::RoversController do
  describe "GET 'index'" do

    context 'with no query parameters' do

      before(:each) do
        @rover = FactoryGirl.create(:rover)
        get :index
      end

      it "returns http 200 success" do
        expect(response.status).to eq 200
      end

      it 'renders rovers json' do
        expect(JSON.parse(response.body)["rovers"].length).to eq 1
      end
    end
  end
end
