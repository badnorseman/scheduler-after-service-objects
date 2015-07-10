require 'rails_helper'

describe ExerciseSetLog, type: :model do
  it "has a valid factory" do
    exercise_set_log = build(:exercise_set_log)
    expect(exercise_set_log).to be_valid
  end

  [:user_id, :coach_id, :exercise_session_log_id].each do |attribute|
    it "should have required attribute #{attribute}" do
      expect(build(:exercise_set_log, attribute => nil)).to be_invalid
    end
  end
end
