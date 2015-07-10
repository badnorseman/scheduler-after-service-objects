FactoryGirl.define do
  factory :habit_description do
    user
    sequence(:name) { |n| "Water#{n}" }
    summary "Drink water"
    description "Drink water"
  end
end
