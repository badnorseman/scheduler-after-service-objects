require 'rails_helper'

describe ExercisePlanLog, type: :model do
  it "has a valid factory" do
    exercise_plan_log = build(:exercise_plan_log)
    expect(exercise_plan_log).to be_valid
  end

  it "should validate length of name" do
    exercise_plan_log = build(:exercise_plan_log,
                              name: "too long name" * 10)
    expect(exercise_plan_log).to be_invalid
  end
end
