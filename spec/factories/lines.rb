FactoryGirl.define do
  factory :line, :class => Avalara::Request::Line do
    line_no "1"
    destination_code "1"
    origin_code "1"
    # item_code "item_code"
    # tax_code "tax_code"
    # customer_usage_type "customer_usage_type"
    qty 1
    amount 10.00
    # discounted "discounted"
    # tax_included "tax_included"
    # ref_1 "ref_1"
    # ref_2 "ref_2"
  end
end
