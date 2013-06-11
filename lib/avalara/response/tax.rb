module Avalara
  module Response
    class Tax < Avalara::Types::Stash
      property :rate,        :from => :Rate
      property :tax,         :from => :Tax
      property :tax_details, :from => :TaxDetails

      property :result_code, :from => :ResultCode
      property :messages,    :from => :Messages

      def success?
        result_code != 'Error'
      end

      def Messages=(new_messages)
        self.messages = new_messages.map {|message| Message.new(message)}
      end

      def TaxDetails=(details)
        self.tax_details = details.map {|tax_detail| TaxDetail.new(tax_detail)}
      end
    end
  end
end
