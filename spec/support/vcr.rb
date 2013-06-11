# encoding: UTF-8

require 'uri'
VCR.configure do |config|
  def uri_encode(value)
    URI.encode(value, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  end

  config.cassette_library_dir = File.expand_path('../../fixtures/net', __FILE__)
  config.default_cassette_options = { :record => :once }
  config.hook_into :webmock

  config.filter_sensitive_data('API_BASIC_AUTH') {
    "#{uri_encode(AVALARA_CONFIGURATION['username'])}:#{uri_encode(AVALARA_CONFIGURATION['password'])}"
  }
  config.filter_sensitive_data('API_ENDPOINT') { URI.parse(AVALARA_CONFIGURATION['endpoint']).host }
end

RSpec.configure do |config|
  config.extend(VCR::RSpec::Macros)
end
