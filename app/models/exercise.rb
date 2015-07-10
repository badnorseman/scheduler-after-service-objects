class Exercise < ActiveRecord::Base
  belongs_to :exercise_description
  belongs_to :user
  belongs_to :exercise_set, inverse_of: :exercises

  # Validate associations
  validates :exercise_description, :exercise_set, :user, presence: true

  # Validate attributes
  validates :tempo, length: { maximum: 8 }
  validate :number_of_properties_selected_presence
  validate :number_of_properties_presence
  validate :unilateral_loading_presence

  # Tempo:
  # Array of 4 sets of 2 charaters given a total of 8 charaters
  # 1-2: Number seconds from start position to end position
  # 3-4: Number seconds to rest in end position
  # 5-6: Number seconds to return to start position
  # 7-8: Number seconds to rest in start position

  private

  def number_of_properties_selected_presence
    count = present_count([:distance_selected, :duration_selected, :repetition_selected])
    errors.add(:base, "Exercise can not have more than two properties selected") if count > 2
    errors.add(:base, "Exercise must have one property selected") if count == 0
  end

  def number_of_properties_presence
    count = present_count([:distance, :duration, :repetition])
    errors.add(:base, "Exercise must have one property with value") if count == 0
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
