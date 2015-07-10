class Profile < ActiveRecord::Base
  belongs_to :user

  # Validate attributes
  # validates :first_name, presence: true, length: {maximum: 100}
  # validates :last_name,  presence: true, length: {maximum: 100}
  # validates :company,                  length: {maximum: 100}
  # validates :address1,                 length: {maximum: 100}
  # validates :address2,                 length: {maximum: 100}
  # validates :postal_code,              length: {maximum: 20}
  # validates :city,                     length: {maximum: 100}
  # validates :state_province,           length: {maximum: 100}
  # validates :country,                  length: {maximum: 100}
  # validates :phone_number,             length: {maximum: 20}
  # validates :gender,                   length: {maximum: 1}
  # validates :birth_date,
  # validates :height,
  # validates :weight
end
