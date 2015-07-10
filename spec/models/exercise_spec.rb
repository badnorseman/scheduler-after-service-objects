require "rails_helper"

describe Exercise, type: :model do
  it "has a valid factory" do
    exercise = build(:exercise)
    expect(exercise).to be_valid
  end

  it "should have one property selected" do
    exercise = build(:exercise,
                     repetition_selected: false,
                     duration_selected: false,
                     distance_selected: false)
    expect(exercise).to be_invalid
  end

  it "shouldn't have more than two properties selected" do
    exercise = build(:exercise,
                     repetition_selected: true,
                     duration_selected: true,
                     distance_selected: true)
    expect(exercise).to be_invalid
  end

  it "should have one property" do
    exercise = build(:exercise,
                     repetition: 10,
                     duration: nil,
                     distance: nil)
    expect(exercise).to be_valid
  end

  it "should have one property" do
    exercise = build(:exercise,
                     repetition: nil,
                     duration: nil,
                     distance: nil)
    expect(exercise).to be_invalid
  end

  it "should have unilateral_loading only if load is selected" do
    exercise = build(:exercise,
                     load: nil,
                     unilateral_loading: true)
    expect(exercise).to be_invalid
  end

  it "can have unilateral_loading if load is selected" do
    exercise = build(:exercise,
                     load: true,
                     unilateral_loading: true)
    expect(exercise).to be_valid
  end

  it "should validate length of tempo" do
    exercise = build(:exercise_description,
                     tempo: '990099009')
    expect(exercise).to be_invalid
  end
end
