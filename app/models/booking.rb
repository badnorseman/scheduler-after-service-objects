class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :coach, class: User

  default_scope { where(canceled_at: nil) }

  # Validate associations
  validates :user, :coach, presence: true

  # Validate attributes
  validates :start_at,
            :end_at,
            presence: true
  validate :start_at_now_or_in_future
  validate :start_at_before_end_at

  private

  def start_at_now_or_in_future
    if start_at &&
      start_at < Time.zone.now
      errors.add(:start_at, "should be now or in future")
    end
  end

  def start_at_before_end_at
    if start_at &&
      end_at &&
      start_at >= end_at
      errors.add(:start_at, "should be before end at")
    end
  end

  # Not required on Booking. Move check to Scheduler.rb
  # def timeshift_is_valid
  #   if timeshift % availability.duration != 0
  #     errors.add(:start_at, "hasn't valid timeshift")
  #   end
  # end
  # def timeshift
  #   (availability.beginning_of_business_day.seconds_since_midnight - start_at.seconds_since_midnight) / 60
  # end
end
