require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module MarsRoverPhotoApi
  class Application < Rails::Application
    config.middleware.use Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: [:get]
      end
    end
    config.public_file_server.enabled = true
    config.api_only = true
  end
end
