FactoryGirl.define do
  factory :booking do
    user
    coach
    start_at Time.zone.parse("9:00AM") + 1.day
    end_at Time.zone.parse("10:00AM") + 1.day
  end
end
