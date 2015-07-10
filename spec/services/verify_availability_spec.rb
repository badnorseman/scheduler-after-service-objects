require "rails_helper"

describe VerifyAvailability do
  before do
    @coach = create(:coach)
    @availability = create(:availability,
                           coach: @coach,
                           start_at: 1.day.from_now.change(usec: 0),
                           end_at: 1.week.from_now.change(usec: 0),
                           maximum_of_participants: 1)
  end

  it "should have availability" do
    expect(VerifyAvailability.new(coach_id: @coach.id,
                                  start_at: @availability.start_at,
                                  end_at: @availability.start_at + @availability.duration.minutes,
                                  maximum_of_participants: @availability.maximum_of_participants).call).to eq(true)
  end

  it "shouldn't have availability" do
    create(:booking,
           coach: @coach,
           start_at: @availability.start_at,
           end_at: @availability.start_at + @availability.duration.minutes)

    expect(VerifyAvailability.new(coach_id: @coach.id,
                                  start_at: @availability.start_at,
                                  end_at: @availability.start_at + @availability.duration.minutes,
                                  maximum_of_participants: @availability.maximum_of_participants).call).to eq(false)
  end
end
