source 'https://rubygems.org'

# this is needed for Heroku to know what Ruby we're using
ruby '3.2.2'

gem 'pg', '~> 1.0'
gem 'rake'
gem 'rails', '~> 7.0.8'
gem 'nokogiri', '~>1.12'
gem 'active_model_serializers', '~> 0.9.3'
gem 'rack-cors', require: 'rack/cors'
gem 'newrelic_rpm'
gem 'redis'
gem 'kaminari'
gem 'tzinfo-data'

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'codeclimate-test-reporter', require: nil
  gem 'fakeredis'
end

group :production do
  gem 'rails_12factor'
  gem 'uglifier'
  gem 'puma'
end
