FactoryGirl.define do
  factory :transaction do
    credit_card_number "4242424242424242"
    credit_card_expiration_date ""
    result "success"
    created_at  "2009-03-25 09:54:09 UTC"
    updated_at  "2010-03-25 09:54:09 UTC"
  end
end
