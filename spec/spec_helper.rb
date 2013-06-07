# encoding: UTF-8

require 'bundler/setup'
Bundler.require(:default, :development)

# Requires supporting files with custom matchers and macros, etc.,
# in ./support/ and its subdirectories.
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each do |file|
  require(file)
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.mock_with :rspec
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run_including :focus
  config.run_all_when_everything_filtered = true
end
