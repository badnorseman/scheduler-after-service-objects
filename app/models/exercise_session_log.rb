class ExerciseSessionLog < ActiveRecord::Base
  belongs_to :exercise_plan_log, inverse_of: :exercise_session_logs
  belongs_to :user
  belongs_to :coach, class: User
  has_many :exercise_set_logs, inverse_of: :exercise_session_log, dependent: :destroy

  # Validate associations
  validates :exercise_plan_log, :user, :coach, presence: true
end
