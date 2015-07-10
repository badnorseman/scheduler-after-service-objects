class ExercisePlan < ActiveRecord::Base
  belongs_to :user
  has_many :exercise_sessions, inverse_of: :exercise_plan, dependent: :destroy

  default_scope { where(ended_at: nil) }

  before_validation :set_uniquable_name

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
  validates :uniquable_name, uniqueness: { scope: :user }

  private

  def set_uniquable_name
    self.uniquable_name = Normalizer.new(text: name).call if name_changed?
  end
end
