require "rails_helper"

describe Scheduler::DailySchedule do
  before do
    @availability = create(:availability)
    @daily_schedule = Scheduler::DailySchedule.new(availability: @availability, date: @availability.start_at.to_date).to_hash
  end

  it "should include time" do
    time = @availability.beginning_of_business_day

    expect(@daily_schedule[time]).to be_truthy
  end

  it "shouldn't include time" do
    time = @availability.end_of_business_day + @availability.duration

    expect(@daily_schedule[time]).to be_falsey
  end

  it "should have exact times" do
    times = ((@availability.end_of_business_day - @availability.beginning_of_business_day) /
              1.minute /
              @availability.duration).to_i

    expect(@daily_schedule.count).to eq(times)
  end
end
