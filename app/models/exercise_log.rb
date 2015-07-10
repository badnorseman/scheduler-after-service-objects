class ExerciseLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :coach, class: User
  belongs_to :exercise_description
  belongs_to :exercise_set_log, inverse_of: :exercise_logs

  # Validate associations
  validates :exercise_description, :user, :coach, presence: true

  # Validate attributes
  validates :tempo, length: { maximum: 8 }
  validate :number_of_properties_presence
  validate :unilateral_loading_presence

  private

  def number_of_properties_presence
    count = present_count([:distance, :duration, :repetition])
    errors.add(:base, "Exercise can not have more than two properties selected") if count > 2
    errors.add(:base, "Exercise must have one property selected") if count == 0
  end

  def unilateral_loading_presence
    if unilateral_loading.present? && load.blank?
      errors.add(:unilateral_loading, "can be added only if load is selected")
    end
  end

  def present_count(attrs)
    attrs.count { |attribute| self[attribute].present? }
  end
end
