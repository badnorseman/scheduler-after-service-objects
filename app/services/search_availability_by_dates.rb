class SearchAvailabilityByDates
  def initialize(coach_id:, start_at:, end_at:)
    @coach = coach_id
    @date = start_at.to_date
    @time_from = start_at.to_time
    @time_to = end_at.to_time
    @calendar_day = start_at.to_date.strftime("%A").downcase
  end

  def call
    availability || NullAvailability.new
  end

  private

  def availability
    Availability.order(priority: :desc).
                 find_by("coach_id = :coach AND
                         start_at <= :date AND
                         end_at >= :date AND
                         beginning_of_business_day <= :time_from AND
                         end_of_business_day >= :time_to AND
                         (recurring_calendar_days = '{}' OR
                         recurring_calendar_days @> :calendar_day::text[])",
                         coach: @coach,
                         date: @date,
                         time_from: @time_from,
                         time_to: @time_to,
                         calendar_day: "{#{@calendar_day}}")
  end
end
