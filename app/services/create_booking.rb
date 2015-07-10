lass CreateBooking
  def initialize(user:, params:)
    @user = user
    @coach_id = params.fetch(:coach_id)
    @start_at = params.fetch(:start_at)
    @end_at = params.fetch(:end_at)
  end

  def call
    Booking.create(booking_params) do |booking|
      booking.user = @user
      booking.confirmed_at = Time.zone.now if auto_confirmed?
    end

    # booking || NullBooking.new
    # if available?
    # end
  end

  private

  def auto_confirmed?
    availability.auto_confirmation
  end

  def available?
    VerifyAvailability.new(coach_id: @coach_id,
                           start_at: @start_at,
                           end_at: @end_at,
                           maximum_of_participants: availability.maximum_of_participants).call
  end

  def availability
    SearchAvailabilityByDates.new(coach_id: @coach_id, start_at: @start_at, end_at: @end_at).call
  end

  def booking_params
    { coach_id: @coach_id, start_at: @start_at, end_at: @end_at }
  end
end
