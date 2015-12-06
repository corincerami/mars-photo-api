require 'rails_helper'

RSpec.describe CuriosityScraper, type: :model do
  let!(:curiosity) { create(:rover) }
  let(:scraper) { CuriosityScraper.new }
  describe "@rover" do
    it "should be Curiosity" do
      expect(scraper.rover).to eq curiosity
    end
  end

  describe ".main_page" do
    it "should return a Nokogiri page" do
      expect(scraper.main_page.title).to eq "Raw Images - Mars Science Laboratory"
    end
  end

  describe ".collect_links" do
    it "should return links to each sol" do
      expect(scraper.collect_links).to include "./?s=1004&camera=FHAZ%5F"
    end
  end

  describe ".scrape" do
    let!(:fhaz) { create(:camera, rover: curiosity) }
    it "should create photo objects" do
      class CuriosityScraper
        def collect_links
          ["./?s=1004&camera=FHAZ%5F"]
        end
      end

      expect{ scraper.scrape }.to change { Photo.count }.by(2)
    end
  end
end
