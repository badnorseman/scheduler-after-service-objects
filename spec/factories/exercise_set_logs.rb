FactoryGirl.define do
  factory :exercise_set_log do
    user
    coach
    exercise_session_log
    duration 45
  end
end
