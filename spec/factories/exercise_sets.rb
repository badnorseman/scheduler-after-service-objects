FactoryGirl.define do
  factory :exercise_set do
    user
    exercise_session
    name "1"
    duration 45
  end
end
