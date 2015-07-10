FactoryGirl.define do
  factory :user do
    sequence(:uid) { |n| "user#{n}@fitbird.com" }
    provider "email"
    sequence(:email) { |n| "user#{n}@fitbird.com" }
    password "Test1234"

    after(:create) do |user|
      user.roles << (
        Role.find_by_uniquable_name("user") || \
        FactoryGirl.create(:role, uniquable_name: "user", name: "User")
      )
    end
  end


  factory :coach, class: User do
    sequence(:uid) { |n| "coach#{n}@fitbird.com" }
    provider "email"
    sequence(:email) { |n| "coach#{n}@fitbird.com" }
    password "Test1234"

    after(:create) do |coach|
      coach.roles << (
        Role.find_by_uniquable_name("coach") || \
        FactoryGirl.create(:role, uniquable_name: "coach", name: "Coach")
      )
    end
  end

  factory :administrator, class: User do
    uid "admin@fitbird.com"
    provider "email"
    email "admin@fitbird.com"
    password "Test1234"

    after(:create) do |administrator|
      administrator.roles << (
      Role.find_by_uniquable_name("administrator") || \
      FactoryGirl.create(:role, uniquable_name: "administrator", name: "Administrator")
      )
    end
  end
end
