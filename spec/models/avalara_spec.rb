# encoding: UTF-8

require 'spec_helper'

describe Avalara do
  maintain_contactology_configuration

  let(:configuration) { Avalara.configuration }

  describe '.configuration' do
    it 'yields a Avalara::Configuration instance' do
      Avalara.configuration do |yielded|
        yielded.should be_kind_of Avalara::Configuration
      end
    end

    it 'yields the same configuration instance across multiple calls' do
      Avalara.configuration do |config|
        Avalara.configuration do |config2|
          config.object_id.should == config2.object_id
        end
      end
    end

    it 'returns the configuration when queried' do
      Avalara.configuration do |config|
        Avalara.configuration.object_id.should == config.object_id
      end
    end

    it 'may be explicitly overridden' do
      configuration = Avalara::Configuration.new
      expect {
        Avalara.configuration = configuration
      }.to change(Avalara, :configuration).to(configuration)
    end

    it 'raises an ArgumentError when set to a non-Configuration object' do
      expect {
        Avalara.configuration = 'bad'
      }.to raise_error(ArgumentError)
    end
  end

  describe '.endpoint' do
    it 'returns the configuration endpoint' do
      Avalara.endpoint.should == configuration.endpoint
    end

    it 'overrides the configuration endpoint' do
      expect {
        Avalara.endpoint = 'https://example.local/'
      }.to change(configuration, :endpoint).to('https://example.local/')
    end
  end

  describe '.username' do
    it 'returns the configuration username' do
      configuration.username = 'username'
      Avalara.username.should == configuration.username
    end

    it 'overrides the configuration username' do
      expect {
        Avalara.username = 'username'
      }.to change(configuration, :username).to('username')
    end
  end
  
  describe '.password' do
    it 'returns the configuration password' do
      configuration.password = 'password'
      Avalara.password.should == configuration.password
    end

    it 'overrides the configuration password' do
      expect {
        Avalara.password = 'password'
      }.to change(configuration, :password).to('password')
    end
  end

  describe '.version' do
    it 'returns the configuration version' do
      configuration.version = 'version'
      Avalara.version.should == configuration.version
    end

    it 'overrides the configuration version' do
      expect {
        Avalara.version = 'version'
      }.to change(configuration, :version).to('version')
    end
  end

  describe '.get_tax' do
    let(:doc_date) { Date.parse("January 1, 2012") }
    let(:invoice) { FactoryGirl.build_via_new(:invoice, doc_date: doc_date) }
    let(:request) { Avalara.get_tax(invoice) }

    context 'failure', :vcr do
      let(:invoice) { FactoryGirl.build_via_new(:invoice, customer_code: nil) }
      use_vcr_cassette 'get_tax/failure'

      it 'unsuccessful response' do
        expect(request).to be_kind_of Avalara::Response::Invoice
        expect(request).to_not be_success

        message = request.messages.first
        expect(message.details).to eq "This value must be specified."
        expect(message.refers_to).to eq "CustomerCode"
        expect(message.severity).to eq "Error"
        expect(message.source).to eq "Avalara.AvaTax.Services"
        expect(message.summary).to eq "CustomerCode is required."
      end
    end

    context 'on timeout' do
      it 'raises an avalara timeout error' do
        Avalara::API.should_receive(:post).and_raise(Timeout::Error)
        expect { request }.to raise_error(Avalara::TimeoutError)
      end
    end

    context 'success', :vcr do
      use_vcr_cassette 'get_tax/success'

      it 'successful response' do
        expect(request).to be_kind_of Avalara::Response::Invoice
        expect(request).to be_success

        expect(request.doc_code).to_not be_nil
        expect(request.doc_date).to eq "2012-01-01"
        expect(request.result_code).to eq "Success"
        expect(request.tax_date).to_not be_nil
        expect(request.timestamp).to_not be_nil
        expect(request.total_amount).to eq "10"
        expect(request.total_discount).to eq "0"
        expect(request.total_exemption).to eq "10"
        expect(request.total_tax).to eq "0"
        expect(request.total_tax_calculated).to eq "0"

        expect(request.tax_lines.length).to be 1
        tax_line = request.tax_lines.first
        expect(tax_line.line_no).to eq "1"
        expect(tax_line.tax_code).to eq "P0000000"
        expect(tax_line.taxability).to eq "true"
        expect(tax_line.taxable).to eq "0"
        expect(tax_line.rate).to eq "0"
        expect(tax_line.tax).to eq "0"
        expect(tax_line.discount).to eq "0"
        expect(tax_line.tax_calculated).to eq "0"
        expect(tax_line.exemption).to eq "10"
        expect(tax_line.tax_details.length).to be 1

        tax_detail = tax_line.tax_details.first
        expect(tax_detail.taxable).to eq "0"
        expect(tax_detail.rate).to eq "0"
        expect(tax_detail.tax).to eq "0"
        expect(tax_detail.region).to eq "WA"
        expect(tax_detail.country).to eq "US"
        expect(tax_detail.juris_type).to eq "State"
        expect(tax_detail.juris_name).to eq "WASHINGTON"
        expect(tax_detail.tax_name).to eq "WA STATE TAX"

        expect(request.tax_addresses.length).to be 1
      end
    end
  end

  describe '.geographical_tax' do
    let(:latitude) { '47.627935' }
    let(:sales_amount) { 100 }
    let(:request) { Avalara.geographical_tax(latitude, longitude, sales_amount) }

    context 'success', :vcr do
      let(:longitude) { '-122.51702' }
      use_vcr_cassette 'geographical_tax/success'
      it 'successful response' do
        expect(request).to be_kind_of Avalara::Response::Tax
        expect(request).to be_success

        expect(request.rate).to eq 0.086
        expect(request.tax).to eq 0.86
        expect(request.tax_details).to have(2).items

        state_tax_detail = request.tax_details.first
        expect(state_tax_detail.rate).to eq 0.065
        expect(state_tax_detail.tax).to eq 0.65
        expect(state_tax_detail.juris_type).to eq 'State'

        city_tax_detail = request.tax_details.last
        expect(city_tax_detail.rate).to eq 0.021
        expect(city_tax_detail.tax).to eq 0.21
        expect(city_tax_detail.juris_type).to eq 'City'
      end
    end

    context 'failure', :vcr do
      let(:longitude) { '122.51702' }
      use_vcr_cassette 'geographical_tax/failure'
      it 'unsuccessful response' do
        expect(request).to be_kind_of Avalara::Response::Tax
        expect(request).to_not be_success

        expect(request.rate).to be_nil
        expect(request.tax).to be_nil
        expect(request.tax_details).to be_nil
      end
    end

    context 'on timeout' do
      let(:longitude) { '-122.51702' }
      it 'raises an avalara timeout error' do
        Avalara::API.should_receive(:get).and_raise(Timeout::Error)
        expect { request }.to raise_error(Avalara::TimeoutError)
      end
    end
  end

  describe '.validate_address' do
    let(:address) { FactoryGirl.build_via_new(:address) }
    let(:request) { Avalara.validate_address(address) }

    context 'failure', :vcr do
      let(:address) { FactoryGirl.build_via_new(:address, :postal_code => nil) }
      use_vcr_cassette 'validate_address/failure'
      it 'unsuccessful response' do
        expect(request).to be_kind_of Avalara::Response::AddressValidation
        expect(request).to_not be_success
      end
    end

    context 'success', :vcr do
      use_vcr_cassette 'validate_address/success'
      it 'successful response' do
        expect(request).to be_kind_of Avalara::Response::AddressValidation
        expect(request).to be_success

        expect(request.address).to be_a Avalara::Response::ValidationAddress

        address = request.address
        expect(address.line_1).to eq '250'
        expect(address.line_2).to eq '435 Ericksen Ave NE'
        expect(address.line_3).to be_nil
        expect(address.city).to eq 'Bainbridge Island'
        expect(address.region).to eq 'WA'
        expect(address.country).to eq 'US'
        expect(address.address_type).to eq 'H'
        expect(address.address_type_name).to eq 'High-rise or business complex'
        expect(address.postal_code).to eq '98110-1896'
        expect(address.county).to eq 'Kitsap'
        expect(address.fips_code).to eq '5303500000'
        expect(address.carrier_route).to eq 'C051'
        expect(address.carrier_route_name).to eq 'City delivery'
        expect(address.tax_region_id).to be_nil
        expect(address.post_net).to eq '981101896999'
      end
    end

    context 'on timeout' do
      it 'raises an avalara timeout error' do
        Avalara::API.should_receive(:get).and_raise(Timeout::Error)
        expect { request }.to raise_error(Avalara::TimeoutError)
      end
    end
  end

end
