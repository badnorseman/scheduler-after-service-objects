module Scheduler
  class HourlySchedule
    def initialize(availability:, time:)
      @availability = availability
      @beginning_of_timeslot = time
    end

    def to_hash
      { time: @beginning_of_timeslot.strftime("%l:%M %p"), available: available? }
    end

    private

    def available?
      VerifyAvailability.new(coach_id: @availability.coach_id,
                             start_at: @beginning_of_timeslot,
                             end_at: @beginning_of_timeslot + @availability.duration.minutes,
                             maximum_of_participants: @availability.maximum_of_participants).call
    end
  end
end
