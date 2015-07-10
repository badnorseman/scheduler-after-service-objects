class ExerciseDescription < ActiveRecord::Base
  belongs_to :user
  has_many :exercises
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  default_scope { where(ended_at: nil) }

  before_validation :set_uniquable_name

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
  validates :uniquable_name, uniqueness: { scope: :user }
  validates :short_name_for_mobile, presence: true, length: { maximum: 25 }
  validates :description, presence: true
  validates :tempo, length: { maximum: 8 }
  validates :video_url, length: { maximum: 100 }
  validate :number_of_properties_presence
  validate :unilateral_loading_presence

  def in_use?
    exercise_count + exercise_log_count > 0
  end

  def tag_list
    tags.all.collect(&:name).sort.join(", ")
  end

  def tag_list=(value)
  end

  def self.search_by_tags(tag_list:)
    SearchTaggableByTags.new(tag_list: tag_list).call
  end

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

  def exercise_count
    Exercise.where(exercise_description_id: id).count
  end

  def exercise_log_count
    ExerciseLog.where(exercise_description_id: id).count
  end

  def present_count(attrs)
    attrs.count { |attribute| self[attribute].present? }
  end

  def set_uniquable_name
    self.uniquable_name = Normalizer.new(text: name).call if name_changed?
  end
end
