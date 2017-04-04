require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

RSpec.configure do |config|
  require "json"
  require "support/request_helpers"
  require "factory_girl"
  require "fakeredis/rspec"

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.include Requests::JsonHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
