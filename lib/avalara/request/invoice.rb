# encoding: UTF-8
require 'multi_json'

module Avalara
  module Request
    # Same as GetTaxRequest
    class Invoice < Avalara::Types::Stash
      coerce_key :DocDate, Avalara::Types::Date

      # Set outgoing
      property :CustomerCode,      :from => :customer_code
      property :DocDate,           :from => :doc_date
      property :CompanyCode,       :from => :company_code
      property :Commit,            :from => :commit
      property :CustomerUsageType, :from => :customer_usage_type
      property :Discount,          :from => :discount
      property :DocCode,           :from => :doc_code
      property :PurchaseOrderNo,   :from => :purchase_order_no
      property :ExemptionNo,       :from => :exemption_no
      property :DetailLevel,       :from => :detail_level
      property :DocType,           :from => :doc_type
      property :Lines,             :from => :lines
      property :Addresses,         :from => :addresses
      property :ReferenceCode,     :from => :reference_code

      # CompanyCode defaults to Avalara's configuration.company_code
      def initialize(*args)
        self.CompanyCode = Avalara.configuration.company_code if Avalara.configuration.company_code
        super
      end

      # Shipping Addresses
      def addresses=(addresses)
        self.Addresses = addresses.map {|address| InvoiceAddress.new(address)}
      end

      def lines=(lines)
        self.Lines = lines.map {|line| Line.new(line)}
      end

      def to_json
        MultiJson.encode(self.to_hash, :pretty => true)
      end
    end
  end
end
