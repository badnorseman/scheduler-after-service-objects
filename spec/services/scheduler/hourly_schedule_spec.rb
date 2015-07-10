require "rails_helper"

describe Scheduler::HourlySchedule do
  before do
    @coach = create(:coach)
    @availability = create(:availability,
                           coach: @coach,
                           start_at: 1.day.from_now.change(usec: 0),
                           end_at: 1.week.from_now.change(usec: 0),
                           maximum_of_participants: 1)
  end

  it "should be available" do
    hourly_schedule = Scheduler::HourlySchedule.new(availability: @availability, time: @availability.start_at).to_hash

    expect(hourly_schedule[:available]).to eq(true)
  end

  it "shouldn't be available" do
    create(:booking,
           coach: @coach,
           start_at: @availability.start_at,
           end_at: @availability.start_at + @availability.duration.minutes)
    hourly_schedule = Scheduler::HourlySchedule.new(availability: @availability, time: @availability.start_at).to_hash

    expect(hourly_schedule[:available]).to eq(false)
  end
end
