# encoding: UTF-8

class Avalara::Configuration

  attr_writer :endpoint
  attr_accessor :password
  attr_accessor :username
  attr_writer :version

  # Public: Changes the default endpoint between production and test.
  # Default: nil
  #
  # set to true to change the default to the test endpoint at 'https://development.avalara.net'
  # set to false or leave default to use the production endpoint at 'https://rest.avalara.net'
  #
  # Returns nil or the value of test
  #
  attr_accessor :test

  ##
  # Public: Get the API endpoint used by the configuration.
  #
  # If the default endpoints are not needed the endpoint can be overridden with another one.
  #
  # Returns the String for the API endpoint.
  #
  def endpoint
    return @endpoint if @endpoint
    test ? 'https://development.avalara.net' : 'https://rest.avalara.net'
  end

  ##
  # Public: Get the API version. Defaults to 1.0.
  #
  # Returns the String for the API version.
  #
  def version
    @version ||= '1.0'
  end
end
