# encoding: UTF-8

module Avalara
  module Response
    class CancelTax < Avalara::Types::Stash
      property :cancel_tax_result, :from => :CancelTaxResult

      delegate :success?,       :to => :cancel_tax_result

      delegate :transaction_id, :to => :cancel_tax_result
      delegate :result_code,    :to => :cancel_tax_result
      delegate :doc_id,         :to => :cancel_tax_result
      delegate :messages,       :to => :cancel_tax_result

      def CancelTaxResult=(result)
        self.cancel_tax_result = CancelTaxResult.new(result)
      end
    end
  end
end
