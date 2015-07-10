require "rails_helper"

describe ExercisesController, type: :controller do
  before do
    coach = create(:coach)
    sign_in coach
    exercise_plan = create(:exercise_plan,
                            user: coach)
    exercise_session = create(:exercise_session,
                               exercise_plan: exercise_plan)
    @exercise_set = create(:exercise_set,
                           exercise_session: exercise_session)
    @exercise_description = create(:exercise_description)
    @exercise = create(:exercise,
                       exercise_set: @exercise_set,
                       exercise_description: @exercise_description,
                       user: coach)
  end

  describe "GET #show" do
    it "should read 1 Exercise" do
      get(
        :show,
        id: @exercise.id)

      expect(json["exercise_description_id"]).to eq(@exercise_description.id)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create Exercise" do
        exercise_attributes =
          attributes_for(:exercise,
                         exercise_set_id: @exercise_set.id,
                         exercise_description_id: @exercise_description.id)
        expect do
          post(
            :create,
            exercise: exercise_attributes)
        end.to change(Exercise, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create Exercise" do
        exercise_attributes =
          attributes_for(:exercise,
                         tempo: "too long value" * 10,
                         exercise_set_id: @exercise_set.id,
                         exercise_description_id: @exercise_description.id)
        expect do
          post(
            :create,
            exercise: exercise_attributes)
        end.to change(Exercise, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update Exercise" do
        tempo = "12X#{rand(100)}"

        patch(
          :update,
          id: @exercise.id,
          exercise: { tempo: tempo } )

        expect(Exercise.find(@exercise.id).tempo).to eq(tempo)
      end
    end

    context "with invalid attributes" do
      it "should not update Exercise" do
        tempo = "too long value" * 10

        patch(
          :update,
          id: @exercise.id,
          exercise: { tempo: tempo } )

        expect(Exercise.find(@exercise.id).tempo).to eq(@exercise.tempo)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete Exercise" do
      expect do
        delete(
          :destroy,
          id: @exercise.id)
      end.to change(Exercise, :count).by(-1)
    end
  end
end
