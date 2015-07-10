FactoryGirl.define do
  factory :payment_plan do
    user
    name "FitBird"
    description "FitBird"
    price 100.00
    currency_iso_code "USD"
    billing_day_of_month "First day of month"
    number_of_billing_cycles 12
    billing_frequency 1
  end
end
