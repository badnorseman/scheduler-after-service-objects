require "rails_helper"

describe HabitDescription, type: :request do
  before do
    coach = create(:coach)
    @tokens = coach.create_new_auth_token("test")
    @habit_description = create_list(:habit_description,
                                     2,
                                     user: coach).first
  end

  describe "Unauthorized request" do
    before do
      get "/api/habit_descriptions.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #index" do
    before do
      get(
        "/api/habit_descriptions.json",
        {},
        @tokens)
    end

    it "should respond with array of 2 Habits" do
      expect(json.count).to eq 2
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    before do
      get(
        "/api/habit_descriptions/#{@habit_description.id}.json",
        {},
        @tokens)
    end

    it "should respond with 1 Habit" do
      expect(json["name"]).to eq(@habit_description.name)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @habit_description_attributes = attributes_for(:habit_description, tag_list: "")

        post(
          "/api/habit_descriptions.json",
          { habit_description: @habit_description_attributes },
          @tokens)
      end

      it "should respond with created Habit" do
        expect(json["name"]).to eq @habit_description_attributes[:name]
      end

      it "should respond with Tags for created Habit" do
        expect(json["tag_list"]).to eq @habit_description_attributes[:tag_list]
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
        habit_description_attributes =
          attributes_for(:habit_description, name: nil)

        post(
          "/api/habit_descriptions.json",
          { habit_description: habit_description_attributes },
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
        @name = "Sleep #{rand(24)} hours daily"
        @tag_list = ""

        patch(
          "/api/habit_descriptions/#{@habit_description.id}.json",
          { habit_description: { name: @name, tag_list: @tag_list } },
          @tokens)
      end

      it "should respond with updated Habit" do
        expect(json["name"]).to eq @name
      end

      it "should respond with Tags for updated Habit" do
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
          "/api/habit_descriptions/#{@habit_description.id}.json",
          { habit_description: { name: name } },
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
        "/api/habit_descriptions/#{@habit_description.id}.json",
        {},
        @tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
