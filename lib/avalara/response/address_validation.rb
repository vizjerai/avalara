# encoding: UTF-8

module Avalara
  module Response
    class AddressValidation < Avalara::Types::Stash
      property :address,     :from => :Address

      property :result_code, :from => :ResultCode
      property :messages,    :from => :Messages

      def success?
        result_code == 'Success'
      end

      def Address=(address)
        self.address = ValidationAddress.new(address)
      end

      def Messages=(new_messages)
        self.messages = []
        new_messages.each do |message|
          self.messages << Message.new(message)
        end
      end

    end
  end
end
