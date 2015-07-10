require 'rails_helper'

describe Payment, type: :model do
  it "has a valid factory" do
    payment = build(:payment)
    expect(payment).to be_valid
  end
end
