# encoding: UTF-8

module Avalara
  module Response
    class Invoice < Avalara::Types::Stash
      property :doc_code,             :from => :DocCode
      property :doc_date,             :from => :DocDate
      property :timestamp,            :from => :Timestamp
      property :total_amount,         :from => :TotalAmount
      property :total_discount,       :from => :TotalDiscount
      property :total_exemption,      :from => :TotalExemption
      property :total_taxable,        :from => :TotalTaxable
      property :total_tax,            :from => :TotalTax
      property :total_tax_calculated, :from => :TotalTaxCalculated
      property :tax_date,             :from => :TaxDate
      property :tax_lines,            :from => :TaxLines
      property :tax_addresses,        :from => :TaxAddresses
      property :result_code,          :from => :ResultCode
      property :messages,             :from => :Messages

      def success?
        result_code == 'Success'
      end

      def Messages=(new_messages)
        self.messages = new_messages.map {|message| Message.new(message)}
      end

      def TaxLines=(lines)
        self.tax_lines = lines.map {|line| TaxLine.new(line)}
      end

      def TaxAddresses=(addresses)
        self.tax_addresses = addresses.map {|address| TaxAddress.new(address)}
      end
    end
  end
end
