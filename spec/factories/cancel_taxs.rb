FactoryGirl.define do
  factory :cancel_tax, :class => Avalara::Request::CancelTax do
    company_code 83
    doc_type 'SalesInvoice'
    doc_code '1234'
    cancel_code 'DocVoided'
    #doc_id '12345678' #avatax's internal document_id
  end
end
