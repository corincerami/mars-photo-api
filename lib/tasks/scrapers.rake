# lib/tasks/scrapers.rake
namespace :scraper do
  desc "Run the Curiosity rover scraper to populate photos"
  task curiosity: :environment do
    puts "Starting Curiosity Scraper..."
    scraper = CuriosityScraper.new
    scraper.scrape
    puts "Curiosity Scraper completed."
  end

  desc "Run the Perseverance rover scraper to populate photos"
  task perseverance: :environment do
    puts "Starting Perseverance Scraper..."
    scraper = PerseveranceScraper.new
    scraper.scrape
    puts "Perseverance Scraper completed."
  end

  desc "Run the Opportunity and Spirit rover scraper to populate photos"
  task opportunity_spirit: :environment do
    puts "Starting Opportunity and Spirit Scraper..."
    scraper = OpportunitySpiritScraper.new
    scraper.scrape
    puts "Opportunity and Spirit Scraper completed."
  end
end
