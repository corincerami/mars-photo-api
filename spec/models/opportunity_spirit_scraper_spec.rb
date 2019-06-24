# Opportunity and Spirit are now both inactive, so no further scraping is planned

# require 'rails_helper'
#
# RSpec.describe OpportunitySpiritScraper, type: :model do
#   let!(:rolver) { create(:rover, name: "Opportunity") }
#   let(:scraper) { OpportunitySpiritScraper.new("Opportunity") }
#
#   before(:each) do
#     stub_const "OpportunitySpiritScraper::SOL_SELECT_CSS_PATHS", ["#Engineering_Cameras_Front_Hazcam"]
#   end
#
#   describe ".main_page" do
#     it "should return a Nokogiri page" do
#       expect(scraper.main_page.title).to eq "Mars Exploration Rover Mission: Multimedia: All Raw Images: Opportunity"
#     end
#   end
#
#   describe ".sol_paths" do
#     it "should return paths for individual sol pages" do
#       expect(scraper.sol_paths).to include "opportunity_f4688.html"
#     end
#   end
#
#   describe ".scrape" do
#     it "should create photos" do
#       allow(scraper).to receive(:sol_paths).and_return ["opportunity_f4688.html"]
#       expect{ scraper.scrape }.to change { Photo.count }.by(2)
#     end
#   end
# end
