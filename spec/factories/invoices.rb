FactoryGirl.define do
  factory :invoice do
    customer_id 5
    merchant_id 26
    status "shipped"
  end
end
