class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  # Validate associations
  validates :tag, presence: true

  # Validate attributes
  validates :taggable_id, presence: true
end
