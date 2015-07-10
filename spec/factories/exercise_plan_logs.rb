FactoryGirl.define do
  factory :exercise_plan_log do
    user
    coach
    sequence(:name) { |n| "My Plan#{n}" }
    sequence(:note) { |n| "Plan desc#{n}" }
  end
end
