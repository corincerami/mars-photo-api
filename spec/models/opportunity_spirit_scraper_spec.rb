require 'rails_helper'

RSpec.describe OpportunitySpiritScraper, type: :model do
  before(:each) do
    stub_const "OpportunitySpiritScraper::SOL_SELECT_CSS_PATHS", ["select[id^=Engineering_Cameras_Entry]"]
  end

  describe ".main_page" do
    it "should return a Nokogiri page" do
      opp = FactoryGirl.create(:rover, name: "Opportunity")
      scraper = OpportunitySpiritScraper.new("Opportunity")

      expect(scraper.main_page.title).to eq "Mars Exploration Rover Mission: Multimedia: All Raw Images: Opportunity"
    end
  end

  describe ".sol_paths" do
    it "should return paths for individual sol pages" do
      opp = FactoryGirl.create(:rover, name: "Opportunity")
      scraper = OpportunitySpiritScraper.new("Opportunity")

      expect(scraper.sol_paths).to eq ["opportunity_e001.html"]
    end
  end

  describe ".scrape" do
    it "should create photos" do
      opp = FactoryGirl.create(:rover, name: "Opportunity")
      scraper = OpportunitySpiritScraper.new("Opportunity")

      expect{ scraper.scrape }.to change { Photo.count }.by(3)
    end
  end
end
