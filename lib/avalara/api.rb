# encoding: UTF-8
require 'httparty'
require 'avalara/parser'

module Avalara
  class API
    include HTTParty
    headers 'Accept' => 'application/json', 'Content-Type' => 'text/json'
    format :json
    parser Parser

    def self.headers_for(content_length = 0)
      {
        'Accept'         => 'application/json',
        'Content-Type'   => 'text/json',
        'Date'           => Time.now.httpdate(),
        'User-Agent'     => user_agent_string,
        "Content-Length" => content_length.to_s
      }
    end

    private

    def self.user_agent_string
      "avalara/#{Avalara::VERSION} (Rubygems; Ruby #{RUBY_VERSION} #{RUBY_PLATFORM})"
    end
  end
end
