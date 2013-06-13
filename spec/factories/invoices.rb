FactoryGirl.define do
  factory :invoice, :class => Avalara::Request::Invoice do
    customer_code 1
    doc_date Time.now
    company_code 83
    # commit false
    # customer_usage_type "customer_usage_type"
    # discount "discount"
    # doc_code "1234"
    # purchase_order_no "purchase_order_no"
    # exemption_no "exemption_no"
    # detail_level 'Tax'
    # doc_type "SalesInvoice"
    # payment_date Time.now
    lines { [FactoryGirl.build_via_new(:line)] }
    addresses { [FactoryGirl.build_via_new(:invoice_address)] }
    # reference_code "reference_code"
  end
end
