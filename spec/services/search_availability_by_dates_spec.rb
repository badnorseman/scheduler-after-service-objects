require "rails_helper"

describe SearchAvailabilityByDates do
  before do
    @coach = create(:coach)
    @start_at = Time.zone.parse("9:00AM") + 1.day
    @end_at = Time.zone.parse("10:00AM") + 1.day
  end

  it "should have availability" do
    create(:availability,
           coach: @coach,
           maximum_of_participants: 3)
    availability = SearchAvailabilityByDates.new(coach_id: @coach.id, start_at: @start_at, end_at: @end_at).call

    expect(availability.maximum_of_participants).to eq(3)
  end

  it "shouldn't have availability" do
    create(:availability,
           coach: @coach,
           maximum_of_participants: 0)
    availability = SearchAvailabilityByDates.new(coach_id: @coach.id, start_at: @start_at, end_at: @end_at).call

    expect(availability.maximum_of_participants).to eq(0)
  end

  it "should have availability on recurring calendar day" do
    tomorrow = Time.zone.tomorrow.strftime("%A").downcase
    create(:availability,
           coach: @coach,
           recurring_calendar_days: tomorrow)
    availability = SearchAvailabilityByDates.new(coach_id: @coach.id, start_at: @start_at, end_at: @end_at).call

    expect(availability.maximum_of_participants).to eq(1)
  end

  it "shouldn't have availability on date" do
    create(:availability,
           coach: @coach,
           start_at: 1.week.from_now,
           end_at: 2.weeks.from_now)
    availability = SearchAvailabilityByDates.new(coach_id: @coach.id, start_at: @start_at, end_at: @end_at).call

    expect(availability.maximum_of_participants).to eq(0)
  end
end
