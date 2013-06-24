# encoding: UTF-8

require 'uri'
VCR.configure do |config|
  def uri_encode(value)
    URI.encode(value, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  end

  config.cassette_library_dir = 'spec/fixtures/net'
  config.default_cassette_options = { :record => :once }
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.filter_sensitive_data('API_BASIC_AUTH') {
    "#{uri_encode(Avalara.username)}:#{uri_encode(Avalara.password)}"
  }
  config.filter_sensitive_data('API_ENDPOINT') { URI.parse(Avalara.endpoint).host }
end
