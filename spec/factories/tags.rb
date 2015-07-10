FactoryGirl.define do
  factory :tag do
    user
    sequence(:name) { |n| "Tag" + "#{n}" }
  end
end
