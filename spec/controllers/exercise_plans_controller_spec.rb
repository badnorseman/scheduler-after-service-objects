require "rails_helper"

describe ExercisePlansController, type: :controller do
  before do
    coach = create(:coach)
    sign_in coach
    @exercise_plan = create_list(:exercise_plan,
                                 2,
                                 user: coach).first
  end

  describe "GET #index" do
    before do
      another_coach = create(:coach)
      create_list(:exercise_plan,
                  2,
                  user: another_coach)
    end

    it "should query 2 ExercisePlans" do
      get(:index)

      expect(json.count).to eq(2)
    end
  end

  describe "GET #show" do
    it "should read 1 ExercisePlan" do
      get(
        :show,
        id: @exercise_plan.id)

      expect(json["name"]).to eq(@exercise_plan.name)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create ExercisePlan" do
        exercise_plan_attributes =
          attributes_for(:exercise_plan)

        expect do
          post(
            :create,
            exercise_plan: exercise_plan_attributes)
        end.to change(ExercisePlan, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create ExercisePlan" do
        exercise_plan_attributes =
          attributes_for(:exercise_plan,
                         name: nil)
        expect do
          post(
            :create,
            exercise_plan: exercise_plan_attributes)
        end.to change(ExercisePlan, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update ExercisePlan" do
        name = "Name #{rand(100)}"

        patch(
          :update, id: @exercise_plan.id,
          exercise_plan: { name: name } )

        expect(ExercisePlan.find(@exercise_plan.id).name).to eq(name)
      end
    end

    context "with invalid attributes" do
      it "should not update ExercisePlan" do
        name = "too long name" * 10

        patch(
          :update,
          id: @exercise_plan.id,
          exercise_plan: { name: name } )

        expect(ExercisePlan.find(@exercise_plan.id).name).to eq(@exercise_plan.name)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete ExercisePlan" do
      expect do
        delete(
          :destroy,
          id: @exercise_plan.id)
      end.to change(ExercisePlan, :count).by(-1)
    end
  end
end
