require "rails_helper"

describe ExerciseSetsController, type: :controller do
  before do
    coach = create(:coach)
    sign_in coach
    exercise_plan = create(:exercise_plan,
                            user: coach)
    @exercise_session = create(:exercise_session,
                               exercise_plan: exercise_plan)
    @exercise_set = create(:exercise_set,
                           exercise_session: @exercise_session,
                           user: coach)
  end

  describe "GET #show" do
    it "should read 1 ExerciseSet" do
      get(
        :show,
        id: @exercise_set.id)

      expect(json["name"]).to eq(@exercise_set.name)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create ExerciseSet" do
        exercise_set_attributes =
          attributes_for(:exercise_set,
                         exercise_session_id: @exercise_session.id)
        expect do
          post(
            :create,
            exercise_set: exercise_set_attributes)
        end.to change(ExerciseSet, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create ExerciseSet" do
        exercise_set_attributes =
          attributes_for(:exercise_set,
                         name: nil,
                         exercise_session_id: @exercise_session.id)
        expect do
          post(
            :create,
            exercise_set: exercise_set_attributes)
        end.to change(ExerciseSet, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update ExerciseSet" do
        name = "Name #{rand(100)}"

        patch(
          :update,
          id: @exercise_set.id,
          exercise_set: { name: name } )

        expect(ExerciseSet.find(@exercise_set.id).name).to eq(name)
      end
    end

    context "with invalid attributes" do
      it "should not update ExerciseSet" do
        name = "too long name" * 10

        patch(
          :update,
          id: @exercise_set.id,
          exercise_set: { name: name } )

        expect(ExerciseSet.find(@exercise_set.id).name).to eq(@exercise_set.name)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete ExerciseSet" do
      expect do
        delete(
          :destroy,
          id: @exercise_set.id)
      end.to change(ExerciseSet, :count).by(-1)
    end
  end
end
