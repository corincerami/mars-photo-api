require 'rails_helper'

RSpec.describe CuriosityScraper, type: :model do
  let!(:curiosity) { create(:rover) }
  let(:scraper) { CuriosityScraper.new }
  describe "#rover" do
    it "should be Curiosity" do
      expect(scraper.rover).to eq curiosity
    end
  end

  describe ".main_page" do
    it "should return a Nokogiri page" do
      expect(scraper.main_page.title).to eq "Raw Images | Multimedia – NASA’s Mars Exploration Program "
    end
  end

  describe ".collect_links" do
    it "should return links to each sol" do
      expect(scraper.collect_links).to include "https://mars.nasa.gov/msl/raw/listimagesraw.cfm?&s=1004"
    end
  end

  describe ".scrape" do
    let!(:fhaz) { create :camera, rover: curiosity, name: "FHAZ" }
    let!(:rhaz) { create :camera, rover: curiosity, name: "RHAZ" }
    it "should create photo objects" do
      allow(scraper).to receive(:collect_links).and_return ["https://mars.nasa.gov/msl/raw/listimagesraw.cfm?&s=1004"]

      expect{ scraper.scrape }.to change { Photo.count }.by(4)
    end
  end
end
