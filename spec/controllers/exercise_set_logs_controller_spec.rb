require "rails_helper"

describe ExerciseSetLogsController, type: :controller do
  before do
    @coach = create(:coach)
    @user = create(:user)
    sign_in @coach
    exercise_plan_log = create(:exercise_plan_log,
                                user: @user,
                                coach: @coach)
    @exercise_session_log = create(:exercise_session_log,
                                   exercise_plan_log: exercise_plan_log,
                                   user: @user,
                                   coach: @coach)
    @exercise_set_log = create(:exercise_set_log,
                               exercise_session_log: @exercise_session_log,
                               user: @user,
                               coach: @coach)
  end

  describe "GET #show" do
    it "should read 1 ExerciseSetLog" do
      get(
        :show,
        id: @exercise_set_log.id)

      expect(json["duration"]).to eq(@exercise_set_log.duration)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create ExerciseSetLog" do
        exercise_set_log_attributes =
          attributes_for(:exercise_set_log,
                         user_id: @user.id,
                         coach_id: @coach.id,
                         exercise_session_log_id: @exercise_session_log.id)
        expect do
          post(
            :create,
            exercise_set_log: exercise_set_log_attributes)
        end.to change(ExerciseSetLog, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create ExerciseSetLog" do
        exercise_set_log_attributes =
          attributes_for(:exercise_set_log,
                         exercise_session_log_id: nil,
                         user_id: @user.id,
                         coach_id: @coach.id)
        expect do
          post(
            :create,
            exercise_set_log: exercise_set_log_attributes)
        end.to change(ExerciseSetLog, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update ExerciseSetLog" do
        duration = rand(100)

        patch(
          :update,
          id: @exercise_set_log.id,
          exercise_set_log: { duration: duration } )

        expect(ExerciseSetLog.find(@exercise_set_log.id).duration).to eq(duration)
      end
    end

    context "with invalid attributes" do
      it "should not update ExerciseSetLog" do
        exercise_session_log_id = nil

        patch(
          :update,
          id: @exercise_set_log.id,
          exercise_set_log: { exercise_session_log: exercise_session_log_id } )

        expect(ExerciseSetLog.find(@exercise_set_log.id).exercise_session_log_id).to eq(@exercise_set_log.exercise_session_log_id)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete ExerciseSetLog" do
      expect do
        delete(
          :destroy,
          id: @exercise_set_log.id)
      end.to change(ExerciseSetLog, :count).by(-1)
    end
  end
end
