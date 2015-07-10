class HabitLog < ActiveRecord::Base
  belongs_to :habit_description
  belongs_to :user

  default_scope { where(ended_at: nil) }

  before_create :number_of_not_ended

  serialize :logged_at, Array

  # Validate associations
  validates :habit_description, :user, presence: true

  def logged?
    logged_at_count > 0
  end

  private

  def number_of_not_ended
    errors.add(:base, "You can only have ten habits at a time") if not_ended_count >= 10
  end

  def not_ended_count
    HabitLog.where(user_id: user.id).count
  end

  def logged_at_count
    self.logged_at.count
  end
end
