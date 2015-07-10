require "rails_helper"

describe BookingsController, type: :controller do
  before do
    @coach = create(:coach)
    user = create(:user)
    sign_in user
    create(:availability,
           coach: @coach,
           start_at: Date.today,
           end_at: Date.today + 1.week,
           duration: 60,
           beginning_of_business_day: Time.zone.parse("9:00AM"),
           end_of_business_day: Time.zone.parse("9:00PM"),
           auto_confirmation: true)
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

  describe "GET #index" do
    it "should query 2 Bookings" do
      get(:index)

      expect(json.count).to eq 2
    end
  end

  describe "GET #show" do
    it "should read 1 Booking" do
      get(
        :show,
        id: @booking.id)

      expect(json["start_at"]).to eq(@booking.start_at.as_json)
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
      end

      it "should create Booking" do
        expect do
          post(
            :create,
            booking: @booking_attributes)
        end.to change(Booking, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create Booking" do
        booking_attributes =
          attributes_for(:booking,
                         coach_id: @coach.id,
                         start_at: Time.zone.parse("9:00AM") + 3.days,
                         end_at: Time.zone.parse("10:00AM") + 2.days)
        expect do
          post(
            :create,
            booking: booking_attributes)
        end.to change(Booking, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update Booking" do
        booking_attributes =
          { start_at: @booking.start_at + 4.hours,
            end_at: @booking.end_at + 4.hours }

        patch(
          :update,
          id: @booking.id,
          booking: booking_attributes)

        expect(Booking.find(@booking.id).start_at).to eq(booking_attributes[:start_at])
      end
    end

    context "with invalid attributes" do
      it "should not update Booking" do
        booking_attributes =
          { start_at: @booking.start_at + 6.hours,
            end_at: @booking.start_at + 5.hours }

        patch(
          :update,
          id: @booking.id,
          booking: booking_attributes)

        expect(Booking.find(@booking.id).start_at).to eq(@booking.start_at)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete Booking" do
      expect do
        delete(
          :destroy,
          id: @booking.id)
      end.to change(Booking.where(canceled_at: nil), :count).by(-1)
    end
  end
end
