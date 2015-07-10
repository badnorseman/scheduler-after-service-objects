require "rails_helper"

describe Availability, type: :model do
  it "has a valid factory" do
    availability = build(:availability)
    expect(availability).to be_valid
  end

  it "should have start on to be before end on" do
    availability = build(:availability,
                         start_at: Time.current,
                         end_at: 1.day.ago)
    expect(availability).to be_invalid
  end

  it "should have beginning of business day to be before end of business day" do
    availability = build(:availability,
                         beginning_of_business_day: Time.zone.parse("3:00PM"),
                         end_of_business_day: Time.zone.parse("1:00PM"))
    expect(availability).to be_invalid
  end
end
