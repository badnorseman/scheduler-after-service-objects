class Habit < ActiveRecord::Base
  belongs_to :habit_description
  belongs_to :product, inverse_of: :habits

  # Validate associations
  validates :habit_description, :product, presence: true

  # Validate attributes
  validates :unit, presence: true, length: { maximum: 50 }
end
