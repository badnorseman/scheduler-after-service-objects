FactoryGirl.define do
  factory :exercise_plan do
    user
    sequence(:name) { |n| "My Plan#{n}" }
    sequence(:description) { |n| "Plan desc#{n}" }
  end
end
