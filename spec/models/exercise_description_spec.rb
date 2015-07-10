require "rails_helper"

describe ExerciseDescription, type: :model do
  it "has a valid factory" do
    exercise_description = build(:exercise_description)
    expect(exercise_description).to be_valid
  end

  it "should validate length of tempo" do
    exercise_description = build(:exercise_description,
                                 tempo: '990099009')
    expect(exercise_description).to be_invalid
  end

  it "should validate length of name" do
    exercise_description = build(:exercise_description,
                                 name: "Too long name" * 10)
    expect(exercise_description).to be_invalid
  end

  it "should validate length of short name for mobile" do
    exercise_description = build(:exercise_description,
                                 short_name_for_mobile: "Too long name" * 50)
    expect(exercise_description).to be_invalid
  end

  it "should validate length of video url" do
    exercise_description = build(:exercise_description,
                                 video_url: "http://www.youtube.com" * 125)
    expect(exercise_description).to be_invalid
  end

  it "should have one property selected" do
    exercise_description = build(:exercise_description,
                                 repetition: false,
                                 duration: false,
                                 distance: false)
    expect(exercise_description).to be_invalid
  end

  it "shouldn't have more than two properties selected" do
    exercise_description = build(:exercise_description,
                                 repetition: true,
                                 duration: true,
                                 distance: true)
    expect(exercise_description).to be_invalid
  end

  it "should have unilateral_loading only if load is selected" do
    exercise_description = build(:exercise_description,
                                 load: nil,
                                 unilateral_loading: true)
    expect(exercise_description).to be_invalid
  end

  it "can have unilateral_loading if load is selected" do
    exercise_description = build(:exercise_description,
                                 load: true,
                                 unilateral_loading: true)
    expect(exercise_description).to be_valid
  end

  it "should create uniquable name" do
    exercise_description = create(:exercise_description)
    expect(exercise_description.uniquable_name).not_to be_empty
  end
end
