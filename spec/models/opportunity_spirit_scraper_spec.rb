require 'rails_helper'

RSpec.describe OpportunitySpiritScraper, type: :model do
  describe ".main_page" do
    it "should return a Nokogiri page" do
      opp = FactoryGirl.create(:rover, name: "Opportunity")
      scraper = OpportunitySpiritScraper.new("Opportunity")

      expect(scraper.main_page.title).to eq "Mars Exploration Rover Mission: Multimedia: All Raw Images: Opportunity"
    end
  end
end
