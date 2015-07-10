module Scheduler
  class ReconciledSchedule
    def initialize(coach:)
      @coach = coach
    end

    def to_hash
      availabilities.inject({}) do |schedule, availability|
        schedule.merge!(Schedule.new(availability: availability).to_hash)
      end
    end

    private

    def availabilities
      @coach.availabilities.future_sorted_by_priority
    end
  end
end
