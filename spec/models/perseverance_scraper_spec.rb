require 'rails_helper'

RSpec.describe PerseveranceScraper, type: :model do
  let!(:perseverance) { create(:rover, name: "Perseverance", landing_date: Date.new(2021, 2, 18), launch_date: Date.new(2020, 7, 30), status: "active") }
  let(:scraper) { PerseveranceScraper.new }

  describe "#rover" do
    it "should be Perseverance" do
      expect(scraper.rover).to eq perseverance
    end
  end

  describe ".collect_links" do
    it "should return links to each sol" do
      expect(scraper.collect_links).to include "https://mars.nasa.gov/rss/api/?feed=raw_images&category=mars2020&feedtype=json&sol=1"
    end
  end

  describe ".scrape" do
    let!(:erucam) { create :camera, rover: perseverance, name: "EDL_RUCAM" }
    let!(:erdcam) { create :camera, rover: perseverance, name: "EDL_RDCAM" }
    let!(:edocam) { create :camera, rover: perseverance, name: "EDL_DDCAM" }
    let!(:epu1cam) { create :camera, rover: perseverance, name: "EDL_PUCAM1" }
    let!(:epu2cam) { create :camera, rover: perseverance, name: "EDL_PUCAM2" }
    let!(:navlcam) { create :camera, rover: perseverance, name: "NAVCAM_LEFT" }
    let!(:navrcam) { create :camera, rover: perseverance, name: "NAVCAM_RIGHT" }
    let!(:mczlcam) { create :camera, rover: perseverance, name: "MCZ_LEFT" }
    let!(:mczrcam) { create :camera, rover: perseverance, name: "MCZ_RIGHT" }
    let!(:fhlacam) { create :camera, rover: perseverance, name: "FRONT_HAZCAM_LEFT_A" }
    let!(:fhracam) { create :camera, rover: perseverance, name: "FRONT_HAZCAM_RIGHT_A" }
    let!(:fhlbcam) { create :camera, rover: perseverance, name: "FRONT_HAZCAM_LEFT_B" }
    let!(:fhrbcam) { create :camera, rover: perseverance, name: "FRONT_HAZCAM_RIGHT_B" }
    let!(:rhlcam) { create :camera, rover: perseverance, name: "REAR_HAZCAM_LEFT" }
    let!(:rhrcam) { create :camera, rover: perseverance, name: "REAR_HAZCAM_RIGHT" }
    let!(:skycam) { create :camera, rover: perseverance, name: "SKYCAM" }
    let!(:waston) { create :camera, rover: perseverance, name: "SHERLOC_WATSON" }
    let!(:supercam) { create :camera, rover: perseverance, name: "SUPERCAM_RMI" }
    let!(:lcam) { create :camera, rover: perseverance, name: "LCAM" }

    before(:each) do
      allow(scraper).to receive(:collect_links).and_return ["https://mars.nasa.gov/rss/api/?feed=raw_images&category=mars2020&feedtype=json&sol=1"]
    end

    it "should create photo objects" do
      expect{ scraper.scrape }.to change { Photo.count }.by(34)
    end

    context "finds an invalid camera name" do
      before(:each) do
        allow($stdout).to receive(:write) # stub stdout
        allow(scraper).to receive(:camera_from_json).and_return('NOT_A_CAMERA')
      end

      it "should not create any photos" do
        expect { scraper.scrape }.to change { Photo.count }.by(0)
      end

      it "should print a warning" do
        expect { scraper.scrape }.to output(/WARNING: Camera not found. Name: NOT_A_CAMERA/).to_stdout
      end
    end
  end
end
