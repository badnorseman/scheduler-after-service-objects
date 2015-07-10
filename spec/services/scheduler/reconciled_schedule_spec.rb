require "rails_helper"

describe Scheduler::ReconciledSchedule do
  before do
    @coach = create(:coach)
  end

  it "should be a hash" do
    reconciled_schedule = Scheduler::ReconciledSchedule.new(coach: @coach).to_hash

    expect(reconciled_schedule.class).to eq(Hash)
  end

  context "when availability" do
    it "should have exact dates" do
      create(:availability,
             coach: @coach,
             start_at: beginning_of_month,
             end_at: end_of_month,
             priority: 1)
      reconciled_schedule = Scheduler::ReconciledSchedule.new(coach: @coach).to_hash

      expect(reconciled_schedule.count).to eq(days_in_month)
    end
  end

  context "when availability with recurring calendar days" do
    it "should have exact dates" do
      create(:availability,
             coach: @coach,
             start_at: beginning_of_second_month,
             end_at: end_of_second_month,
             recurring_calendar_days: calendar_days,
             priority: 1)
      reconciled_schedule = Scheduler::ReconciledSchedule.new(coach: @coach).to_hash

      expect(reconciled_schedule.count).to eq(recurring_calendar_days)
    end
  end

  context "when availabilities" do
    it "should have exact dates" do
      create(:availability,
             coach: @coach,
             start_at: beginning_of_month,
             end_at: end_of_month,
             priority: 1)
     create(:availability,
            coach: @coach,
            start_at: beginning_of_second_month,
            end_at: end_of_second_month,
            recurring_calendar_days: calendar_days,
            priority: 1)
      reconciled_schedule = Scheduler::ReconciledSchedule.new(coach: @coach).to_hash

      expect(reconciled_schedule.count).to eq(days_in_month + recurring_calendar_days)
    end
  end

  context "when availabilities with overlap" do
    it "should have exact dates" do
      create(:availability,
             coach: @coach,
             start_at: beginning_of_month,
             end_at: beginning_of_second_month,
             priority: 1)
     create(:availability,
            coach: @coach,
            start_at: end_of_month,
            end_at: end_of_second_month,
            recurring_calendar_days: calendar_days,
            priority: 2)
      reconciled_schedule = Scheduler::ReconciledSchedule.new(coach: @coach).to_hash

      expect(reconciled_schedule.count).to eq(days_in_month + recurring_calendar_days)
    end
  end
end

def beginning_of_month
  days_to_beginning_of_month.days.from_now.change(usec: 0)
end

def beginning_of_second_month
  days_to_beginning_of_second_month.days.from_now.change(usec: 0)
end

def end_of_month
  days_to_end_of_month.days.from_now.change(usec: 0)
end

def end_of_second_month
  days_to_end_of_second_month.days.from_now.change(usec: 0)
end

def days_to_beginning_of_month
  Time.days_in_month(Time.zone.now.month) - (Time.zone.yesterday.day)
end

def days_to_beginning_of_second_month
  Time.days_in_month(month) - (Time.zone.yesterday.day - 1) + days_in_month
end

def days_to_end_of_month
  Time.days_in_month(month) - Time.zone.yesterday.day + days_in_month
end

def days_to_end_of_second_month
  days_to_beginning_of_second_month + days_in_second_month - 1
end

def days_in_month
  Time.days_in_month(month)
end

def days_in_second_month
  Time.days_in_month(second_month)
end

def month
  Time.zone.now.month + 1
end

def second_month
  month + 1
end

def recurring_calendar_days
  (beginning_of_second_month.to_date..end_of_second_month.to_date).inject(0) do |count, day|
    count += 1 if calendar_days.include?(day.strftime("%A").downcase)
    count
  end
end

def calendar_days
  [beginning_of_second_month.strftime("%A").downcase]
end
