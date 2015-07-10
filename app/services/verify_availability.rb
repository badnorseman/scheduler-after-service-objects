class VerifyAvailability
  def initialize(coach_id:, start_at:, end_at:, maximum_of_participants:)
    @coach_id = coach_id
    @start_at = start_at
    @end_at = end_at
    @maximum_of_participants = maximum_of_participants
  end

  def call
    @maximum_of_participants > number_of_booked_participants
  end

  private

  def number_of_booked_participants
    CountBookings.new(coach_id: @coach_id, start_at: @start_at, end_at: @end_at).call
  end
end
