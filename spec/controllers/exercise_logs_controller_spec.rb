require "rails_helper"

describe ExerciseLogsController, type: :controller do
  before do
    @user = create(:user)
    @coach = create(:coach)
    sign_in @coach
    @exercise_description = create(:exercise_description,
                                   user: @coach)
    @exercise_log = create(:exercise_log,
                           exercise_description: @exercise_description,
                           user: @user,
                           coach: @coach)
  end

  describe "GET #show" do
    it "should read 1 ExerciseLog" do
      get(
        :show,
        id: @exercise_log.id)

      expect(json["exercise_description_id"]).to eq(@exercise_description.id)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create ExerciseLog" do
        exercise_log_attributes =
          attributes_for(:exercise_log,
                         exercise_description_id: @exercise_description.id,
                         user_id: @user.id,
                         coach_id: @coach.id)
        expect do
          post(
            :create,
            exercise_log: exercise_log_attributes)
        end.to change(ExerciseLog, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create ExerciseLog" do
        exercise_log_attributes =
          attributes_for(:exercise_log,
                         load: nil,
                         unilateral_loading: true,
                         exercise_description_id: @exercise_description.id,
                         user_id: @user.id,
                         coach_id: @coach.id)
        expect do
          post(
            :create,
            exercise_log: exercise_log_attributes)
        end.to change(ExerciseLog, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update Exercise" do
        tempo = "12X#{rand(100)}"

        patch(
          :update,
          id: @exercise_log.id,
          exercise_log: { tempo: tempo } )

        expect(ExerciseLog.find(@exercise_log.id).tempo).to eq(tempo)
      end
    end

    context "with invalid attributes" do
      it "should not update Exercise" do
        tempo = "too long value" * 10

        patch(
          :update,
          id: @exercise_log.id,
          exercise_log: { tempo: tempo } )

        expect(ExerciseLog.find(@exercise_log.id).tempo).to eq(@exercise_log.tempo)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete Exercise" do
      expect do
        delete(
          :destroy,
          id: @exercise_log.id)
      end.to change(ExerciseLog, :count).by(-1)
    end
  end
end
