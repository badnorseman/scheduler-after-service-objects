FactoryGirl.define do
  factory :exercise_description do
    user
    sequence(:name) { |n| "Push-ups#{n}" }
    short_name_for_mobile "Push-ups"
    description "Push-ups with no weight"
    distance false
    duration false
    load false
    repetition true
    tempo ""
    video_url "http://www.youtube.com"
    unilateral_execution false
    unilateral_loading false
  end
end
