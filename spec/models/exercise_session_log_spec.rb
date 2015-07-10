require 'rails_helper'

describe ExerciseSessionLog, type: :model do
  it "has a valid factory" do
    exercise_session_log = build(:exercise_session_log)
    expect(exercise_session_log).to be_valid
  end

  [:user_id, :coach_id, :exercise_plan_log_id].each do |attribute|
    it "should have required attribute #{attribute}" do
      expect(build(:exercise_session_log, attribute => nil)).to be_invalid
    end
  end
end
