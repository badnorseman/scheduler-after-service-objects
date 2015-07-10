class ExercisePlanLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :coach, class: User

  has_many :exercise_session_logs, inverse_of: :exercise_plan_log, dependent: :destroy

  default_scope { where(ended_at: nil) }

  # Validate associations
  validates :user, :coach, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
end
