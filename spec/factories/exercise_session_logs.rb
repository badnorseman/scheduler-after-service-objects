FactoryGirl.define do
  factory :exercise_session_log do
    user
    coach
    exercise_plan_log
  end
end
