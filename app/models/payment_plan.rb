class PaymentPlan < ActiveRecord::Base
  belongs_to :user
  has_many :payments, inverse_of: :payment_plan
  has_many :users, through: :payments

  # Validate associations
  validates :user, presence: true

  # Validate attributes
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :currency_iso_code, presence: true, length: { maximum: 3 }
  validates :price,
            :billing_day_of_month,
            :number_of_billing_cycles,
            :billing_frequency,
            presence: true
end
