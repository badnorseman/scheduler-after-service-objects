class ExerciseSetLog < ActiveRecord::Base
  belongs_to :exercise_session_log, inverse_of: :exercise_set_logs
  belongs_to :user
  belongs_to :coach, class: User
  has_many :exercise_logs, inverse_of: :exercise_set_log, dependent: :destroy

  # Validate associations
  validates :exercise_session_log, :user, :coach, presence: true
end
