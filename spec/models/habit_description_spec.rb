require "rails_helper"

describe HabitDescription, type: :model do
  it "has a valid factory" do
    habit_description = build(:habit_description)
    expect(habit_description).to be_valid
  end

  it "should validate name length" do
    habit_description = build(:habit_description,
                              name: "Too long name" * 10)
    expect(habit_description).to be_invalid
  end

  it "should validate summary length" do
    habit_description = build(:habit_description,
                              summary: "Too long summary" * 125)
    expect(habit_description).to be_invalid
  end

  it "should create uniquable name" do
    habit_description = create(:habit_description)
    expect(habit_description.uniquable_name).not_to be_empty
  end
end
