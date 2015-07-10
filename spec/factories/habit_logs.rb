FactoryGirl.define do
  factory :habit_log do
    habit_description
    user
    logged_at []
  end
end
