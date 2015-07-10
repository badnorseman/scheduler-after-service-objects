require 'rails_helper'

describe ExercisePlan, type: :model do
  it "has a valid factory" do
    exercise_plan = build(:exercise_plan)
    expect(exercise_plan).to be_valid
  end

  it "should validate name length" do
    exercise_plan = build(:exercise_plan,
                          name: "Too long name" * 10)
    expect(exercise_plan).to be_invalid
  end

  it "should create uniquable name" do
    exercise_plan = create(:exercise_plan)
    expect(exercise_plan.uniquable_name).not_to be_empty
  end
end
