FactoryGirl.define do
  factory :exercise do
    user
    exercise_set
    exercise_description
    distance_selected true
    distance 100
    duration_selected true
    duration 45
    load_selected true
    load 80.5
    repetition_selected false
    repetition nil
    rest 15
    tempo "12X1"
  end
end
