# encoding: UTF-8

module Avalara
  module Response
    class CancelTaxResult < Avalara::Types::Stash
      property :transaction_id, :from => :TransactionId
      property :result_code,    :from => :ResultCode
      property :doc_id,         :from => :DocId
      property :messages,       :from => :Messages

      def success?
        result_code == 'Success'
      end

      def Messages=(new_messages)
        self.messages = new_messages.map {|message| Message.new(message)}
      end
    end
  end
end
