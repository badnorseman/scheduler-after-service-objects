class Product < ActiveRecord::Base
  belongs_to :user
  has_many :habits, inverse_of: :product, dependent: :destroy

  has_many :users

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
end
