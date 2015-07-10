class ExerciseSet < ActiveRecord::Base
  belongs_to :exercise_session, inverse_of: :exercise_sets
  belongs_to :user
  has_many :exercises, inverse_of: :exercise_set, dependent: :destroy

  # Validate associations
  validates :exercise_session, :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
end
