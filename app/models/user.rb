class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  before_create :skip_confirmation!

  has_and_belongs_to_many :roles
  has_one :profile, dependent: :destroy
  has_many :availabilities, class: Availability, foreign_key: :coach_id, dependent: :destroy
  has_many :bookings, class: Booking, foreign_key: :coach_id
  has_many :exercise_descriptions
  has_many :exercise_plans
  has_many :habit_descriptions
  has_many :habit_descriptions, through: :habit_logs
  has_many :habit_logs, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :payment_plans, through: :payments
  has_many :payment_plans
  has_many :products
  has_many :tags

  def administrator?
    roles.exists?(uniquable_name: "administrator")
  end

  def coach?
    roles.exists?(uniquable_name: "coach")
  end

  def client?
    roles.exists?(uniquable_name: "client")
  end
end
