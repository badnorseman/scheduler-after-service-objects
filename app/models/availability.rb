class Availability < ActiveRecord::Base
  belongs_to :coach, class: User

  scope :future_sorted_by_priority, -> { order(priority: :asc).where("end_at >= ?", Time.zone.now) }

  before_save :set_defaults

  # Validate associations
  validates :coach, presence: true

  # Validate attributes
  validates :start_at,
            :end_at,
            :beginning_of_business_day,
            :end_of_business_day,
            :duration,
            :cancellation_period,
            :late_cancellation_fee,
            presence: true

  validate :beginning_of_business_day_before_end_of_business_day
  validate :start_at_before_end_at

  private

  def beginning_of_business_day_before_end_of_business_day
    if beginning_of_business_day >= end_of_business_day
      errors.add(:beginning_of_business_day, "should be before end of business")
    end
  end

  def start_at_before_end_at
    if start_at &&
      end_at &&
      start_at > end_at
      errors.add(:start_at, "should be before end at")
    end
  end

  def set_defaults
    self.recurring_calendar_days ||= []
    self.maximum_of_participants ||= 1
    self.priority ||= 1
  end
end
