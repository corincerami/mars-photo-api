curiosity_scraper: rake scrape_curiosity
opportunity_scraper: rake scrape_opportunity
web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
web: bundle exec puma -C config/puma.rb
