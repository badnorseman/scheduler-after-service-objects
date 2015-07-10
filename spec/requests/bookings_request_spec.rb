require "rails_helper"

describe Booking, type: :request do
  before do
    @coach = create(:coach)
    user = create(:user)
    @tokens = user.create_new_auth_token("test")
    create(:availability,
           coach: @coach,
           duration: 60)
    @booking = create(:booking,
                      user: user,
                      coach: @coach,
                      start_at: Time.zone.parse("9:00AM") + 1.day,
                      end_at: Time.zone.parse("10:00AM") + 1.day)
    create(:booking,
           user: user,
           coach: @coach,
           start_at: Time.zone.parse("10:00AM") + 1.day,
           end_at: Time.zone.parse("11:00AM") + 1.day)
  end

  describe "Unauthorized request" do
    before do
      get "/api/bookings.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #index" do
    before do
      get(
        "/api/bookings.json",
        {},
        @tokens)
    end

    it "should respond with array of 2 Bookings" do
      expect(json.count).to eq(2)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    before do
      get(
        "/api/bookings/#{@booking.id}.json",
        {},
        @tokens)
    end

    it "should respond with 1 Booking" do
      expect(json["start_at"]).to eq(@booking.start_at.as_json)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @booking_attributes =
          attributes_for(:booking,
                         coach_id: @coach.id,
                         start_at: Time.zone.parse("9:00AM") + 2.days,
                         end_at: Time.zone.parse("10:00AM") + 2.days)
        post(
          "/api/bookings.json",
          { booking: @booking_attributes },
          @tokens)
      end

      it "should respond with created Booking" do
        expect(json["start_at"].as_json).to eq @booking_attributes[:start_at].as_json
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
        booking_attributes =
          attributes_for(:booking,
                         coach_id: @coach.id,
                         start_at: Time.zone.parse("9:00AM") + 3.days,
                         end_at: Time.zone.parse("10:00AM") + 2.days)
        post(
          "/api/bookings.json",
          { booking: booking_attributes },
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
        @booking_attributes =
          { start_at: @booking.start_at + 4.hours,
            end_at: @booking.end_at + 4.hours }

        patch(
          "/api/bookings/#{@booking.id}.json",
          { booking: @booking_attributes },
          @tokens)
      end

      it "should respond with updated Booking" do
        expect(Booking.find(@booking.id).start_at).to eq(@booking_attributes[:start_at])
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        booking_attributes =
          { start_at: @booking.start_at + 6.hours,
            end_at: @booking.start_at + 5.hours }

        patch(
          "/api/bookings/#{@booking.id}.json",
          { booking: booking_attributes },
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
        "/api/bookings/#{@booking.id}.json",
        {},
        @tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
