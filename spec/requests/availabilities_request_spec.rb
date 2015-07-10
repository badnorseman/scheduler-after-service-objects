require "rails_helper"

describe Availability, type: :request do
  before do
    coach = create(:coach)
    @tokens = coach.create_new_auth_token("test")
    @availability = create_list(:availability,
                                2,
                                coach: coach).first
  end

  describe "Unauthorized request" do
    before do
      get "/api/availabilities.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #index" do
    before do
      get(
        "/api/availabilities.json",
        {},
        @tokens)
    end

    it "should respond with array of 2 Availabilities" do
      expect(json.count).to eq(2)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    before do
      get(
        "/api/availabilities/#{@availability.id}.json",
        {},
        @tokens)
    end

    it "should respond with 1 Availability" do
      expect(json["start_at"]).to eq(@availability.start_at.as_json)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @availability_attributes = attributes_for(:availability)

        post(
          "/api/availabilities.json",
          { availability: @availability_attributes },
          @tokens)
      end

      it "should respond with created Availability" do
        expect(json["start_at"]).to eq (@availability_attributes[:start_at]).as_json
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
        availability_attributes =
          attributes_for(:availability, start_at: nil)

        post(
          "/api/availabilities.json",
          { availability: availability_attributes },
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
        @availability_attributes =
          { start_at: @availability.start_at - 1.day,
            end_at: @availability.end_at + 1.day,
            maximum_of_participants: 2 }

        patch(
          "/api/availabilities/#{@availability.id}.json",
          { availability: @availability_attributes },
          @tokens)
      end

      it "should respond with updated Availability" do
        expect(Availability.find(@availability.id).start_at).to eq(@availability_attributes[:start_at].as_json)
        expect(Availability.find(@availability.id).maximum_of_participants).to eq(@availability_attributes[:maximum_of_participants])
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        availability_attributes =
          { start_at: @availability.start_at + 6.days,
            end_at: @availability.start_at + 5.days }

        patch(
          "/api/availabilities/#{@availability.id}.json",
          { availability: availability_attributes },
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
        "/api/availabilities/#{@availability.id}.json",
        {},
        @tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
