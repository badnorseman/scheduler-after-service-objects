require "rails_helper"

describe Exercise, type: :request do
  before do
    coach = create(:coach)
    @tokens = coach.create_new_auth_token("test")
    exercise_plan = create(:exercise_plan,
                            user: coach)
    exercise_session = create(:exercise_session,
                               exercise_plan: exercise_plan)
    @exercise_set = create(:exercise_set,
                           exercise_session: exercise_session)
    @exercise_description = create(:exercise_description)
    @exercise = create_list(:exercise,
                            2,
                            exercise_set: @exercise_set,
                            exercise_description: @exercise_description,
                            user: coach).first
  end

  describe "Unauthorized request" do
    before do
      get "/api/exercises/#{@exercise.id}.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #show" do
    before do
      get(
        "/api/exercises/#{@exercise.id}.json",
        { exercise_set_id: @exercise_set.id },
        @tokens)
    end

    it "should respond with 1 Exercise" do
      expect(json["load"]).to eq(@exercise.load.as_json)
    end

    it "should respond with status 200" do
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @exercise_attributes =
          attributes_for(:exercise,
                         exercise_set_id: @exercise_set.id,
                         exercise_description_id: @exercise_description.id)
        post(
          "/api/exercises.json",
          { exercise: @exercise_attributes },
          @tokens)
      end

      it "should respond with created Exercise" do
        expect(json["load"]).to eq @exercise_attributes[:load].to_json
      end

      it "should respond with status 201" do
        expect(response.status).to eq 201
      end
    end

    context "with invalid attributes" do
      before do
        exercise_attributes =
          attributes_for(:exercise,
                         tempo: "too long value",
                         exercise_set_id: @exercise_set.id,
                         exercise_description_id: @exercise_description.id)
        post(
          "/api/exercises.json",
          { exercise: exercise_attributes },
          @tokens)
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
        @tempo = "12X#{rand(100)}"

        patch(
          "/api/exercises/#{@exercise.id}.json",
          { exercise: { tempo: @tempo } },
          @tokens)
      end

      it "should respond with updated Exercise" do
        expect(json["tempo"]).to eq @tempo
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        tempo = "too long value" * 10

        patch(
          "/api/exercises/#{@exercise.id}.json",
          { exercise: { tempo: tempo } },
          @tokens)
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
      delete(
        "/api/exercises/#{@exercise.id}.json",
        {},
        @tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
