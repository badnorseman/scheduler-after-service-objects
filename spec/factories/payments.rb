FactoryGirl.define do
  factory :payment do
    user
    payment_plan
    sequence(:transaction_id) { |n| "TransactionId" + "#{n}" }
    sequence(:customer_id) { |n| "CustomerId" + "#{n}" }
  end
end
