require 'rails_helper'

RSpec.describe PerseveranceScraper, type: :model do
  let!(:perseverance) { create(:rover) }
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
    let!(:fhaz) { create :camera, rover: perseverance, name: "FHAZ" }
    let!(:rhaz) { create :camera, rover: perseverance, name: "RHAZ" }
    it "should create photo objects" do
      allow(scraper).to receive(:collect_links).and_return ["https://mars.nasa.gov/rss/api/?feed=raw_images&category=mars2020&feedtype=json&sol=1"]

      expect{ scraper.scrape }.to change { Photo.count }.by(191)
    end
  end
end
