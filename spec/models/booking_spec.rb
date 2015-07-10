require "rails_helper"

describe Booking, type: :model do
  it "has a valid factory" do
    booking = build(:booking)
    expect(booking).to be_valid
  end

  it "should have start at to be now or in future" do
    booking = build(:booking,
                    start_at: Time.zone.parse("9:00AM") - 1.day)
    expect(booking).to be_invalid
  end

  it "should have start at to be before end at" do
    booking = build(:booking,
                    start_at: Time.zone.parse("9:00AM") + 2.days,
                    end_at: Time.zone.parse("10:00AM") + 1.day)
    expect(booking).to be_invalid
  end
end
