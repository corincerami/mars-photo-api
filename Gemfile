source 'https://rubygems.org'

ruby "2.2.2"

gem 'pg'
gem 'rake'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
gem 'foundation-rails'
gem 'nokogiri'
gem 'active_model_serializers'

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
