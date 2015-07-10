class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :payment_plan, inverse_of: :payments

  # Validate associations
  validates :user, :payment_plan, presence: true

  # Validate attributes
  validates :transaction_id, :customer_id, presence: true
end
