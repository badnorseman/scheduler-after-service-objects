class ExerciseSession < ActiveRecord::Base
  belongs_to :exercise_plan, inverse_of: :exercise_sessions
  belongs_to :user
  has_many :exercise_sets, inverse_of: :exercise_session, dependent: :destroy

  # Validate associations
  validates :exercise_plan, :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
end
