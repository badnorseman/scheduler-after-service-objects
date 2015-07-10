require "rails_helper"

describe Habit, type: :model do
  it "has a valid factory" do
    habit = build(:habit)
    expect(habit).to be_valid
  end
end
