FactoryGirl.define do
  factory :address, :class => Avalara::Request::Address do
    line_1 "435 Ericksen Avenue Northeast"
    line_2 "#250"
    # line_3 "line_3"
    # city "city"
    # region "region"
    # country "country"
    postal_code "98110"
  end
end
