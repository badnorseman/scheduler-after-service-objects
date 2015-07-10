class CountBookings
  def initialize(coach_id:, start_at:, end_at:)
    @coach = coach_id
    @start_at = start_at
    @end_at = end_at
  end

  def call
    Booking.where("coach_id = :coach AND
                  end_at  > :start_at AND
                  start_at < :end_at",
                  coach: @coach,
                  start_at: @start_at,
                  end_at: @end_at).
                  count
  end
end
