require "rails_helper"

describe Role, type: :model do
  it "has a valid factory" do
    role = build(:role)
    expect(role).to be_valid
  end

  it "should validate name length" do
    role = build(:role,
                 name: "Too long name" * 10)
    expect(role).to be_invalid
  end

  it "should create uniquable name" do
    role = create(:role)
    expect(role.uniquable_name).not_to be_empty
  end
end
