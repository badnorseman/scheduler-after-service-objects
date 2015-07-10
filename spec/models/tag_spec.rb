require 'rails_helper'

describe Tag, type: :model do
  it "has a valid factory" do
    tag = build(:tag)
    expect(tag).to be_valid
  end

  it "should validate length of name" do
    tag = build(:tag,
                name: "Too long name" * 100)
    expect(tag).to be_invalid
  end

  it "should create uniquable name" do
    tag = create(:tag)
    expect(tag.uniquable_name).not_to be_empty
  end
end
