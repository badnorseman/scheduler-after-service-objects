require "rails_helper"

describe ExerciseDescription, type: :request do
  before do
    @coach = create(:coach)
    @tokens = @coach.create_new_auth_token("test")
    @exercise_description = create_list(:exercise_description,
                                        2,
                                        user: @coach).first
  end

  describe "Unauthorized request" do
    before do
      get "/api/exercise_descriptions.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #index" do
    before do
      get(
        "/api/exercise_descriptions.json",
        {},
        @tokens)
    end

    it "should respond with array of 2 ExerciseDescriptions" do
      expect(json.count).to eq(2)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    before do
      get(
        "/api/exercise_descriptions/#{@exercise_description.id}.json",
        {},
        @tokens)
    end

    it "should respond with 1 ExerciseDescription" do
      expect(json["name"]).to eq(@exercise_description.name)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @exercise_description_attributes =
          attributes_for(:exercise_description, tag_list: "Beginner")

        post(
          "/api/exercise_descriptions.json",
          { exercise_description: @exercise_description_attributes,
            user: @coach },
          @tokens)
      end

      it "should respond with created ExerciseDescription" do
        expect(json["name"]).to eq @exercise_description_attributes[:name]
      end

      it "should respond with Tags for created ExerciseDescription" do
        expect(json["tag_list"]).to eq @exercise_description_attributes[:tag_list]
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
        exercise_description_attributes =
          attributes_for(:exercise_description, name: nil)

        post(
          "/api/exercise_descriptions.json",
          { exercise_description: exercise_description_attributes,
            user: @coach },
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
        @tag_list = "Beginner, Strength"

        patch(
          "/api/exercise_descriptions/#{@exercise_description.id}.json",
          { exercise_description: { name: @name, tag_list: @tag_list } },
          @tokens)
      end

      it "should respond with updated ExerciseDescription" do
        expect(ExerciseDescription.find(@exercise_description.id).name).to eq(@name)
      end

      it "should respond with Tags for updated ExerciseDescription" do
        expect(json["tag_list"]).to eq(@tag_list)
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        name = "too long name" * 100

        patch(
          "/api/exercise_descriptions/#{@exercise_description.id}.json",
          { exercise_description: { name: name } },
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
        "/api/exercise_descriptions/#{@exercise_description.id}.json",
        {},
        @tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
