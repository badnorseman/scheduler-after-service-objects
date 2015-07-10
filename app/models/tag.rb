class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :habit_descriptions, through: :taggings, source: :taggable, source_type: HabitDescription
  has_many :exercise_descriptions, through: :taggings, source: :taggable, source_type: ExerciseDescription

  default_scope { where(ended_at: nil) }

  before_validation :set_uniquable_name

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
  validates :uniquable_name, uniqueness: true

  def in_use?
    tagging_count > 0
  end

  private

  def set_uniquable_name
    self.uniquable_name = Normalizer.new(text: name).call if name_changed?
  end

  def tagging_count
    Tagging.where(tag_id: id).count
  end
end
