require 'rails_helper'

describe ExerciseLog, type: :model do
  it "has a valid factory" do
    exercise_log = build(:exercise_log)
    expect(exercise_log).to be_valid
  end

  it "should have one property" do
    exercise_log = build(:exercise_log,
                         repetition: 5,
                         duration: nil,
                         distance: nil)
    expect(exercise_log).to be_valid
  end

  it "should have one property" do
    exercise_log = build(:exercise_log,
                         repetition: nil,
                         duration: nil,
                         distance: nil)
    expect(exercise_log).to be_invalid
  end

  it "shouldn't have more than two properties" do
    exercise_log = build(:exercise_log,
                         repetition: 5,
                         duration: 60,
                         distance: 7)
    expect(exercise_log).to be_invalid
  end

  it "should have unilateral_loading only if load is selected" do
    exercise_log = build(:exercise_log,
                         load: nil,
                         unilateral_loading: true)
    expect(exercise_log).to be_invalid
  end

  it "can have unilateral_loading if load is selected" do
    exercise_log = build(:exercise_log,
                         load: true,
                         unilateral_loading: true)
    expect(exercise_log).to be_valid
  end

  it "should validate length of tempo" do
    exercise_log = build(:exercise_description,
                         tempo: '990099009')
    expect(exercise_log).to be_invalid
  end
end
