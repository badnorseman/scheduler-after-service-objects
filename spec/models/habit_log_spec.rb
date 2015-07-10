require 'rails_helper'

describe HabitLog, type: :model do
  it "has a valid factory" do
    habit_log = build(:habit_log)
    expect(habit_log).to be_valid
  end
end
