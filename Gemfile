source 'https://rubygems.org'

ruby "2.2.2"

gem 'pg'
gem 'rake'
gem 'rails', '4.2.0'
gem 'foundation-rails'
gem 'nokogiri'
gem 'active_model_serializers'
gem 'kaminari'
gem 'rack-cors', require: 'rack/cors'
gem 'newrelic_rpm'

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'pry'
end

group :test do
  gem 'shoulda-matchers'
  gem "codeclimate-test-reporter", require: nil
end

group :production do
  gem 'rails_12factor'
  gem 'uglifier'
  gem 'puma'
end
