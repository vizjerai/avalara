# encoding: UTF-8

module Avalara
  module Response
    class ValidationAddress < Avalara::Types::Stash
      ADDRESS_TYPE_NAME = {
        'F' => 'Firm or company address',
        'G' => 'General Delivery address',
        'H' => 'High-rise or business complex',
        'P' => 'PO Box address',
        'R' => 'Rural route address',
        'S' => 'Street or residential address'
      }
      CARRIER_TYPE = {
        'B' => 'PO Box',
        'C' => 'City delivery',
        'G' => 'General delivery',
        'H' => 'Highway contract',
        'R' => 'Rural route'
      }

      property :line_1,        :from => :Line1
      property :line_2,        :from => :Line2
      property :line_3,        :from => :Line3
      property :city,          :from => :City
      property :region,        :from => :Region
      property :country,       :from => :Country
      property :address_type,  :from => :AddressType
      property :postal_code,   :from => :PostalCode
      property :county,        :from => :County
      property :fips_code,     :from => :FipsCode
      property :carrier_route, :from => :CarrierRoute
      property :tax_region_id, :from => :TaxRegionId
      property :post_net,      :from => :PostNet

      def address_type_name
        ADDRESS_TYPE_NAME[address_type]
      end

      def carrier_route_name
        return carrier_route if carrier_route.nil? || carrier_route.empty?
        CARRIER_TYPE[carrier_route[0]]
      end
    end
  end
end
