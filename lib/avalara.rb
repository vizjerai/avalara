# encoding: UTF-8

require 'avalara/version'
require 'avalara/errors'
require 'avalara/configuration'

require 'avalara/api'

require 'avalara/types'
require 'avalara/request'
require 'avalara/response'

module Avalara

  def self.configuration
    @@_configuration ||= Avalara::Configuration.new
    yield @@_configuration if block_given?
    @@_configuration
  end

  def self.configuration=(configuration)
    raise ArgumentError, 'Expected a Avalara::Configuration instance' unless configuration.kind_of?(Configuration)
    @@_configuration = configuration
  end

  def self.configure(&block)
    configuration(&block)
  end

  def self.company_code
    configuration.company_code
  end
  def self.company_code=(value)
    configuration.company_code = value
  end

  def self.endpoint
    configuration.endpoint
  end
  def self.endpoint=(endpoint)
    configuration.endpoint = endpoint
  end

  def self.username
    configuration.username
  end
  def self.username=(username)
    configuration.username = username
  end

  def self.password
    configuration.password
  end
  def self.password=(password)
    configuration.password = password
  end

  def self.version
    configuration.version
  end
  def self.version=(version)
    configuration.version = version
  end

  def self.cancel_tax(cancel_invoice)
    uri = [endpoint, version, 'tax', 'cancel'].join('/')

    response = API.post(uri,
      :body       => cancel_invoice.to_json,
      :headers    => API.headers_for(cancel_invoice.to_json.length),
      :basic_auth => authorization
    )

    Response::CancelTax.new(response)
  rescue Timeout::Error => e
    raise TimeoutError.new(e)
  end

  def self.geographical_tax(latitude, longitude, sales_amount)
    uri = [endpoint, version, 'tax', "#{latitude},#{longitude}", 'get'].join('/')

    response = API.get(uri, 
      :headers    => API.headers_for(),
      :query      => {:saleamount => sales_amount},
      :basic_auth => authorization
    )

    Response::Tax.new(response)
  rescue Timeout::Error => e
    raise TimeoutError.new(e)
  end

  def self.get_tax(invoice)
    uri = [endpoint, version, 'tax', 'get'].join('/')

    response = API.post(uri,
      :body       => invoice.to_json,
      :headers    => API.headers_for(invoice.to_json.length),
      :basic_auth => authorization
    )

    Response::Invoice.new(response)
  rescue Timeout::Error => e
    raise TimeoutError.new(e)
  rescue ApiError => e
    raise e
  rescue Exception => e
    raise Error.new(e)
  end

  def self.validate_address(address)
    uri = [endpoint, version, 'address', 'validate'].join('/')
    response = API.get(uri,
      :headers => API.headers_for(),
      :query => address.to_hash,
      :basic_auth => authorization
    )
    Response::AddressValidation.new(response)
  rescue Timeout::Error => e
    raise TimeoutError.new(e)
  end

  private

  def self.authorization
    {:username => username, :password => password}
  end
end
