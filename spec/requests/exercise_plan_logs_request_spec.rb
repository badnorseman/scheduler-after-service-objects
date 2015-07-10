require "rails_helper"

describe ExercisePlanLog, type: :request do
  before do
    @user = create(:user)
    @coach = create(:coach)
    @exercise_plan_log = create_list(:exercise_plan_log,
                                     2,
                                     user: @user,
                                     coach: @coach).first
  end

  describe "Unauthorized request" do
    before do
      get "/api/exercise_plan_logs.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #show" do
    before do
      tokens = @user.create_new_auth_token("test")

      get(
        "/api/exercise_plan_logs/#{@exercise_plan_log.id}.json",
        {},
        tokens)
    end

    it "should respond with 1 ExercisePlanLog" do
      expect(json["name"]).to eq(@exercise_plan_log.name)
    end

    it "should respond with status 200" do
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        tokens = @coach.create_new_auth_token("test")
        @exercise_plan_attributes =
          attributes_for(:exercise_plan_log,
                         user_id: @user.id,
                         coach_id: @coach.id)
        post(
          "/api/exercise_plan_logs.json",
          { exercise_plan_log: @exercise_plan_attributes },
          tokens)
      end

      it "should respond with created ExercisePlan" do
        expect(json["name"]).to eq @exercise_plan_attributes[:name]
      end

      it "should respond with new id" do
        expect(json.keys).to include("id")
      end

      it "should respond with status 201" do
        expect(response.status).to eq 201
      end
    end

    context "with invalid attributes" do
      before do
        tokens = @coach.create_new_auth_token("test")
        exercise_plan_attributes =
          attributes_for(:exercise_plan_log,
                         name: nil,
                         user_id: @user.id,
                         coach_id: @coach.id)
        post(
          "/api/exercise_plan_logs.json",
          { exercise_plan_log: exercise_plan_attributes },
          tokens)
      end

      it "should respond with errors" do
        expect(json.keys).to include("errors")
      end

      it "should respond with status 422" do
        expect(response.status).to eq 422
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      before do
        tokens = @user.create_new_auth_token("test")
        @name = "Name #{rand(100)}"

        patch(
          "/api/exercise_plan_logs/#{@exercise_plan_log.id}.json",
          { exercise_plan_log: { name: @name } },
          tokens)
      end

      it "should respond with updated ExercisePlan" do
        expect(ExercisePlanLog.find(@exercise_plan_log.id).name).to eq(@name)
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        tokens = @user.create_new_auth_token("test")
        name = "too long name" * 100

        patch(
          "/api/exercise_plan_logs/#{@exercise_plan_log.id}.json",
          { exercise_plan_log: { name: name } },
          tokens)
      end

      it "should respond with errors" do
        expect(json.keys).to include("errors")
      end

      it "should respond with status 422" do
        expect(response.status).to eq 422
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      tokens = @coach.create_new_auth_token("test")

      delete(
        "/api/exercise_plan_logs/#{@exercise_plan_log.id}.json",
        {},
        tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
