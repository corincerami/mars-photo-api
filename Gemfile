source 'https://rubygems.org'

ruby '2.3.4'

gem 'pg'
gem 'rake'
gem 'rails', '~> 4.2.6'
gem 'nokogiri'
gem 'active_model_serializers', '~> 0.9.3'
gem 'rack-cors', require: 'rack/cors'
gem 'newrelic_rpm'
gem 'redis'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'pry'
  gem 'fakeredis'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
end

group :production do
  gem 'rails_12factor'
  gem 'uglifier'
  gem 'puma'
end
