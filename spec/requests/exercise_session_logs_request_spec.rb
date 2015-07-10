require "rails_helper"

describe ExerciseSessionLog, type: :request do
  before do
    @user = create(:user)
    @coach = create(:coach)
    @exercise_plan_log = create(:exercise_plan_log,
                                user: @user,
                                coach: @coach)
    @exercise_session_log = create_list(:exercise_session_log,
                                        2,
                                        exercise_plan_log: @exercise_plan_log,
                                        user: @user,
                                        coach: @coach).first
  end

  describe "Unauthorized request" do
    before do
      get "/api/exercise_session_logs/#{@exercise_session_log.id}.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #show" do
    before do
      tokens = @user.create_new_auth_token("test")

      get(
        "/api/exercise_session_logs/#{@exercise_session_log.id}.json",
        {},
        tokens)
    end

    it "should respond with 1 ExerciseSessionLog" do
      expect(json["exercise_plan_log_id"]).to eq(@exercise_session_log.exercise_plan_log_id)
    end

    it "should respond with status 200" do
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        tokens = @coach.create_new_auth_token("test")
        @exercise_session_log_attributes =
          attributes_for(:exercise_session_log,
                         exercise_plan_log_id: @exercise_plan_log.id,
                         user_id: @user.id,
                         coach_id: @coach.id)
        post(
          "/api/exercise_session_logs.json",
          { exercise_session_log: @exercise_session_log_attributes },
          tokens)
      end

      it "should respond with created ExerciseSessionLog" do
        expect(json["exercise_plan_log_id"]).to eq @exercise_session_log_attributes[:exercise_plan_log_id]
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
        exercise_session_log_attributes =
          attributes_for(:exercise_session_log,
                         exercise_plan_log_id: nil,
                         user_id: @user.id,
                         coach_id: @coach.id)
        post(
          "/api/exercise_session_logs.json",
          { exercise_session_log: exercise_session_log_attributes },
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
        @started_at = Time.zone.now.change(usec: 0)

        patch(
          "/api/exercise_session_logs/#{@exercise_session_log.id}.json",
          { exercise_session_log: { started_at: @started_at } },
          tokens)
      end

      it "should respond with updated ExerciseSessionLog" do
        expect(json["started_at"]).to eq @started_at.as_json
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        tokens = @user.create_new_auth_token("test")

        patch(
          "/api/exercise_session_logs/#{@exercise_session_log.id}.json",
          { exercise_session_log: { exercise_plan_log_id: "" } },
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
        "/api/exercise_session_logs/#{@exercise_session_log.id}.json",
        {},
        tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
