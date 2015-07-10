require "rails_helper"

describe HabitLog, type: :request do
  before do
    coach = create(:coach)
    @habit_description = create(:habit_description,
                                user: coach)
    user = create(:user)
    @tokens = user.create_new_auth_token("test")
    @habit_log = create_list(:habit_log,
                             2,
                             user: user).first
  end

  describe "Unauthorized request" do
    before do
      get "/api/habit_logs.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #index" do
    before do
      get(
        "/api/habit_logs.json",
        {},
        @tokens)
    end

    it "should respond with an array of 2 Habits" do
      expect(json.count).to eq 2
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    before do
      get(
        "/api/habit_logs/#{@habit_log.id}.json",
        {},
        @tokens)
    end

    it "should respond with 1 HabitLog" do
      expect(json["ended_at"]).to eq(@habit_log.ended_at.as_json)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        habit_log_attributes =
          attributes_for(:habit_log,
                         habit_description_id: @habit_description.id)

        post(
          "/api/habit_logs.json",
          { habit_log: habit_log_attributes },
          @tokens)
      end

      it "should respond with created HabitLog" do
        expect(json["created_at"]).not_to be_nil
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
        habit_log_attributes =
          attributes_for(:habit_log,
                         habit_description_id: nil)
        post(
          "/api/habit_logs.json",
          { habit_log: habit_log_attributes },
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
        @date = Time.current + rand(1000).minutes
        habit_log_attributes = attributes_for(:habit_log)
        habit_log_attributes[:logged_at] << @date

        patch(
          "/api/habit_logs/#{@habit_log.id}.json",
          { habit_log: habit_log_attributes },
          @tokens)
      end

      it "should respond with updated HabitLog" do
        expect(HabitLog.find(@habit_log.id).logged_at).to include(@date.to_s)
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        habit_description_id = nil

        patch(
          "/api/habit_logs/#{@habit_log.id}.json",
          { habit_log: { habit_description_id: habit_description_id } },
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
        "/api/habit_logs/#{@habit_log.id}.json",
        {},
        @tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
