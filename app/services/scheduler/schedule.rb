module Scheduler
  class Schedule
    def initialize(availability:)
      @availability = availability
    end

    def to_hash
      dates.each_with_object({}) do |date, schedule|
        daily_schedule = DailySchedule.new(availability: @availability, date: date)
        schedule[date] = daily_schedule.to_hash if daily_schedule.has_times?
      end
    end

    private

    def dates
      (beginning_of_schedule..end_of_schedule).to_a
    end

    def beginning_of_schedule
      @availability.start_at > Time.zone.now ? @availability.start_at.to_date : Date.current
    end

    def end_of_schedule
      @availability.end_at.to_date
    end
  end
end
