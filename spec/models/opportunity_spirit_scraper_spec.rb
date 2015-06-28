require 'rails_helper'

RSpec.describe OpportunitySpiritScraper, type: :model do
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

      OpportunitySpiritScraper::SOL_SELECT_CSS_PATHS = ["select[id^=Engineering_Cameras_Entry]"]
      expect(scraper.sol_paths).to eq ["opportunity_e001.html"]
    end
  end
end
