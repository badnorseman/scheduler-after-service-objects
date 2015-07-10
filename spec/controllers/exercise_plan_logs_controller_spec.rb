require "rails_helper"

describe ExercisePlanLogsController, type: :controller do
  before do
    @user = create(:user)
    @coach = create(:coach)
    sign_in @coach
    @exercise_plan_log = create_list(:exercise_plan_log,
                                     2,
                                     user: @user,
                                     coach: @coach).first
  end

  describe "GET #index" do
    before do
      another_coach = create(:coach)
      create_list(:exercise_plan_log,
                  2,
                  user: @user,
                  coach: another_coach)
    end

    it "should query 2 ExercisePlanLogs" do
      get(:index)
      expect(json.count).to eq(2)
    end
  end

  describe "GET #show" do
    it "should read 1 ExercisePlanLog" do
      get(
        :show,
        id: @exercise_plan_log.id)
      expect(json["name"]).to eq(@exercise_plan_log.name)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create ExercisePlanLog" do
        exercise_plan_log_attributes =
          attributes_for(:exercise_plan_log,
                         user_id: @user.id,
                         coach_id: @coach.id)
        expect do
          post(
            :create,
            exercise_plan_log: exercise_plan_log_attributes)
        end.to change(ExercisePlanLog, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create ExercisePlanLog" do
        exercise_plan_log_attributes =
          attributes_for(:exercise_plan_log,
                         name: nil,
                         user_id: @user.id,
                         coach_id: @coach.id)
        expect do
          post(
            :create,
            exercise_plan_log: exercise_plan_log_attributes)
        end.to change(ExercisePlanLog, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update ExercisePlanLog" do
        name = "Name #{rand(100)}"

        patch(
          :update, id: @exercise_plan_log.id,
          exercise_plan_log: { name: name } )

        expect(ExercisePlanLog.find(@exercise_plan_log.id).name).to eq(name)
      end
    end

    context "with invalid attributes" do
      it "should not update ExercisePlanLog" do
        name = "too long name" * 10

        patch(
          :update,
          id: @exercise_plan_log.id,
          exercise_plan_log: { name: name } )

        expect(ExercisePlanLog.find(@exercise_plan_log.id).name).to eq(@exercise_plan_log.name)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete ExercisePlanLog" do
      expect do
        delete(
          :destroy,
          id: @exercise_plan_log.id)
      end.to change(ExercisePlanLog, :count).by(-1)
    end
  end
end
