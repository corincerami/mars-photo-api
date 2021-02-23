# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task scrape_perseverance: :environment do
  PerseveranceScraper.new.scrape
end

task scrape_curiosity: :environment do
  CuriosityScraper.new.scrape
end

task scrape_opportunity: :environment do
  OpportunitySpiritScraper.new("Opportunity").scrape
end

task scrape_spirit: :environment do
  OpportunitySpiritScraper.new("Spirit").scrape
end
