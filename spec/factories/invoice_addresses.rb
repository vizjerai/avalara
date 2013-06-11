FactoryGirl.define do
  factory :invoice_address, :class => Avalara::Request::InvoiceAddress do
    address_code 1
    line_1 "435 Ericksen Avenue Northeast"
    line_2 "#250"
    # line_3 "line_3"
    # city "city"
    # region "region"
    # country "country"
    postal_code "98110"
    # latitude "latitude"
    # longitude "longitude"
    # tax_region_id "tax_region_id"
  end
end
