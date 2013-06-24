# encoding: UTF-8
require 'multi_json'

module Avalara
  module Request
    class CancelTax < Avalara::Types::Stash
      property :CompanyCode, :from => :company_code
      property :DocType,     :from => :doc_type
      property :DocCode,     :from => :doc_code
      property :CancelCode,  :from => :cancel_code
      property :DocId,       :from => :doc_id

      # CompanyCode defaults to Avalara's configuration.company_code
      def initialize(*args)
        self.CompanyCode = Avalara.configuration.company_code if Avalara.configuration.company_code
        super
      end

      def to_json
        MultiJson.encode(self.to_hash, :pretty => true)
      end
    end
  end
end
