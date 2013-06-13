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

      def to_json
        MultiJson.encode(self.to_hash, :pretty => true)
      end
    end
  end
end
