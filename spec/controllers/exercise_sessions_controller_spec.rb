require "rails_helper"

describe ExerciseSessionsController, type: :controller do
  before do
    coach = create(:coach)
    sign_in coach
    @exercise_plan = create(:exercise_plan,
                            user: coach)
    @exercise_session = create(:exercise_session,
                               exercise_plan: @exercise_plan,
                               user: coach)
  end

  describe "GET #show" do
    it "should read 1 ExerciseSession" do
      get(
        :show,
        id: @exercise_session.id)

      expect(json["name"]).to eq(@exercise_session.name)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create ExerciseSession" do
        exercise_session_attributes =
          attributes_for(:exercise_session,
                         exercise_plan_id: @exercise_plan.id)
        expect do
          post(
            :create,
            exercise_session: exercise_session_attributes)
        end.to change(ExerciseSession, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create ExerciseSession" do
        exercise_session_attributes =
          attributes_for(:exercise_session,
                         name: nil,
                         exercise_plan_id: @exercise_plan.id)
        expect do
          post(
            :create,
            exercise_session: exercise_session_attributes)
        end.to change(ExerciseSession, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update ExerciseSession" do
        name = "Name #{rand(100)}"

        patch(
          :update,
          id: @exercise_session.id,
          exercise_session: { name: name } )

        expect(ExerciseSession.find(@exercise_session.id).name).to eq(name)
      end
    end

    context "with invalid attributes" do
      it "should not update ExerciseSession" do
        name = "too long name" * 10

        patch(
          :update,
          id: @exercise_session.id,
          exercise_session: { name: name } )

        expect(ExerciseSession.find(@exercise_session.id).name).to eq(@exercise_session.name)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete ExerciseSession" do
      expect do
        delete(
          :destroy,
          id: @exercise_session.id)
      end.to change(ExerciseSession, :count).by(-1)
    end
  end
end
