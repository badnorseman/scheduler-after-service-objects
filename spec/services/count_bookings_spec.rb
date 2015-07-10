require "rails_helper"

describe CountBookings do
  before do
    @coach = create(:coach)
    @start_at = Time.zone.parse("9:00AM") + 1.day
    @end_at = Time.zone.parse("10:00AM") + 1.day
    create_list(:booking,
                2,
                coach: @coach,
                start_at: @start_at,
                end_at: @end_at)
  end

  it "should have count of bookings equal 2" do
    count = CountBookings.new(coach_id: @coach.id, start_at: @start_at, end_at: @end_at).call

    expect(count).to eq(2)
  end
end
