require "rails_helper"

describe Habit, type: :request do
  before do
    coach = create(:coach)
    @tokens = coach.create_new_auth_token("test")
    @product = create(:product,
                      user: coach)
    @habit_description = create(:habit_description,
                                user: coach)
    @habit = create_list(:habit,
                         2,
                         product: @product,
                         habit_description: @habit_description).first
  end

  describe "Unauthorized request" do
    before do
      get "/api/habits.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #index" do
    before do
      get(
        "/api/habits.json",
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
        "/api/habits/#{@habit.id}.json",
        {},
        @tokens)
    end

    it "should respond with 1 Habit" do
      expect(json["habit_description_id"]).to eq(@habit.habit_description_id)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @habit_attributes =
          attributes_for(:habit,
                         product_id: @product.id,
                         habit_description_id: @habit_description.id)
        post(
          "/api/habits.json",
          { habit: @habit_attributes },
          @tokens)
      end

      it "should respond with created Habit" do
        expect(json["habit_description_id"]).to eq @habit_attributes[:habit_description_id]
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
        habit_attributes =
          attributes_for(:habit,
                         product_id: @product.id,
                         habit_description_id: nil)
        post(
          "/api/habits.json",
          { habit: habit_attributes },
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
        @unit = "Kilogram"

        patch(
          "/api/habits/#{@habit.id}.json",
          { habit: { unit: @unit } },
          @tokens)
      end

      it "should respond with updated Habit" do
        expect(json["unit"]).to eq @unit
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        patch(
          "/api/habits/#{@habit.id}.json",
          { habit: { unit: nil } },
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
        "/api/habits/#{@habit.id}.json",
        {},
        @tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
