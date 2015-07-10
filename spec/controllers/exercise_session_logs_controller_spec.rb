require "rails_helper"

describe ExerciseSessionLogsController, type: :controller do
  before do
    @user = create(:user)
    @coach = create(:coach)
    sign_in @coach
    @exercise_plan_log = create(:exercise_plan_log,
                                user: @user,
                                coach: @coach)
    @exercise_session_log = create(:exercise_session_log,
                                   exercise_plan_log: @exercise_plan_log,
                                   user: @user,
                                   coach: @coach)
  end

  describe "GET #show" do
    it "should read 1 ExerciseSessionLog" do
      get(
        :show,
        id: @exercise_session_log.id)

      expect(json["exercise_plan_log_id"]).to eq(@exercise_session_log.exercise_plan_log.id)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create ExerciseSessionLog" do
        exercise_session_log_attributes =
          attributes_for(:exercise_session_log,
                         exercise_plan_log_id: @exercise_plan_log.id,
                         user_id: @user.id,
                         coach_id: @coach.id)
        expect do
          post(
            :create,
            exercise_session_log: exercise_session_log_attributes)
        end.to change(ExerciseSessionLog, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create ExerciseSessionLog" do
        exercise_session_log_attributes =
          attributes_for(:exercise_session_log,
                         exercise_plan_log_id: nil,
                         user_id: @user.id,
                         coach_id: @coach.id)
        expect do
          post(
            :create,
            exercise_session_log: exercise_session_log_attributes)
        end.to change(ExerciseSessionLog, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update ExerciseSessionLog" do
        started_at = Time.zone.now.change(usec: 0)

        patch(
          :update,
          id: @exercise_session_log.id,
          exercise_session_log: { started_at: started_at } )

        expect(ExerciseSessionLog.find(@exercise_session_log.id).started_at).to eq(started_at)
      end
    end

    context "with invalid attributes" do
      it "should not update ExerciseSessionLog" do
        exercise_plan_log_id = nil

        patch(
          :update,
          id: @exercise_session_log.id,
          exercise_session_log: { exercise_plan_log_id: exercise_plan_log_id } )

        expect(ExerciseSessionLog.find(@exercise_session_log.id).exercise_plan_log_id).to eq(@exercise_session_log.exercise_plan_log_id)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete ExerciseSessionLog" do
      expect do
        delete(
          :destroy,
          id: @exercise_session_log.id)
      end.to change(ExerciseSessionLog, :count).by(-1)
    end
  end
end
