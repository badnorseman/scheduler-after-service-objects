require "rails_helper"

describe ExerciseSet, type: :request do
  before do
    coach = create(:coach)
    @tokens = coach.create_new_auth_token("test")
    exercise_plan = create(:exercise_plan,
                            user: coach)
    @exercise_session = create(:exercise_session,
                               exercise_plan: exercise_plan)
    @exercise_set = create_list(:exercise_set,
                                2,
                                exercise_session: @exercise_session,
                                user: coach).first
  end

  describe "Unauthorized request" do
    before do
      get "/api/exercise_sets/#{@exercise_set.id}.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #show" do
    before do
      get(
        "/api/exercise_sets/#{@exercise_set.id}.json",
        {},
        @tokens)
    end

    it "should respond with 1 ExerciseSet" do
      expect(json["name"]).to eq(@exercise_set.name)
    end

    it "should respond with status 200" do
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @exercise_set_attributes =
          attributes_for(:exercise_set,
                         exercise_session_id: @exercise_session.id)
        post(
          "/api/exercise_sets.json",
          { exercise_set: @exercise_set_attributes },
          @tokens)
      end

      it "should respond with created ExerciseSet" do
        expect(json["name"]).to eq @exercise_set_attributes[:name]
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
        exercise_set_attributes =
          attributes_for(:exercise_set,
                         name: nil,
                         exercise_session_id: @exercise_session.id)
        post(
          "/api/exercise_sets.json",
          { exercise_set: exercise_set_attributes },
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
        @name = "Name #{rand(100)}"

        patch(
          "/api/exercise_sets/#{@exercise_set.id}.json",
          { exercise_set: { name: @name } },
          @tokens)
      end

      it "should respond with updated ExerciseSet" do
        expect(json["name"]).to eq @name
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        name = nil

        patch(
          "/api/exercise_sets/#{@exercise_set.id}.json",
          { exercise_set: { name: name } },
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
        "/api/exercise_sets/#{@exercise_set.id}.json",
        {},
        @tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
