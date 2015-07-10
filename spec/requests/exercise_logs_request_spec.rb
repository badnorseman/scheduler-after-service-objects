require "rails_helper"

describe ExerciseLog, type: :request do
  before do
    @user = create(:user)
    @coach = create(:coach)
    @exercise_description = create(:exercise_description,
                                   user: @coach)
    @exercise_log = create_list(:exercise_log,
                                2,
                                exercise_description: @exercise_description,
                                user: @user,
                                coach: @coach).first
  end

  describe "Unauthorized request" do
    before do
      get "/api/exercise_logs/#{@exercise_log.id}.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #show" do
    before do
      tokens = @user.create_new_auth_token("test")

      get(
        "/api/exercise_logs/#{@exercise_log.id}.json",
        {},
        tokens)
    end

    it "should respond with 1 ExerciseLog" do
      expect(json["load"]).to eq(@exercise_log.load.as_json)
    end

    it "should respond with status 200" do
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        tokens = @coach.create_new_auth_token("test")
        @exercise_log_attributes =
          attributes_for(:exercise_log,
                         exercise_description_id: @exercise_description.id,
                         user_id: @user.id,
                         coach: @coach)
        post(
          "/api/exercise_logs.json",
          { exercise_log: @exercise_log_attributes },
          tokens)
      end

      it "should respond with created ExerciseLog" do
        expect(json["load"]).to eq @exercise_log_attributes[:load].to_json
      end

      it "should respond with status 201" do
        expect(response.status).to eq 201
      end
    end

    context "with invalid attributes" do
      before do
        tokens = @coach.create_new_auth_token("test")
        exercise_log_attributes =
          attributes_for(:exercise_log, tempo: "too long value")

        post(
          "/api/exercise_logs.json",
          { exercise_log: exercise_log_attributes,
            exercise_description_id: @exercise_description.id },
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
        @tempo = "12X#{rand(100)}"

        patch(
          "/api/exercise_logs/#{@exercise_log.id}.json",
          { exercise_log: { tempo: @tempo } },
          tokens)
      end

      it "should respond with updated ExerciseLog" do
        expect(json["tempo"]).to eq @tempo
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        tokens = @user.create_new_auth_token("test")
        tempo = "too long value" * 100

        patch(
          "/api/exercise_logs/#{@exercise_log.id}.json",
          { exercise_log: { tempo: tempo } },
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
        "/api/exercise_logs/#{@exercise_log.id}.json",
        {},
        tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
