require "rails_helper"

describe SearchTaggableByTags do
  before do
    @user = create(:user)
    @exercise_description = create(:exercise_description)
  end

  it "should read taggable with tag" do
    Tagger.new(user_id: @user.id,
               taggable: @exercise_description,
               tag_list: "Strength").call
    result = SearchTaggableByTags.new(tag_list: "Strength").call

    expect(result).to include(@exercise_description)
  end

  it "shouldn't read taggable without matching tag" do
    Tagger.new(user_id: @user.id,
               taggable: @exercise_description,
               tag_list: "Advanced").call
    result = SearchTaggableByTags.new(tag_list: "Strength").call

    expect(result).not_to include(@exercise_description)
  end

  it "should read taggable with tags" do
    Tagger.new(user_id: @user.id,
               taggable: @exercise_description,
               tag_list: "Beginner, Strength, Weight Loss").call
    result = SearchTaggableByTags.new(tag_list: "Beginner, Strength, Weight Loss").call

    expect(result).to include(@exercise_description)
  end

  it "shouldn't read taggable without matching tags" do
    Tagger.new(user_id: @user.id,
               taggable: @exercise_description,
               tag_list: "Beginner, Strength, Weight Loss").call
    result = SearchTaggableByTags.new(tag_list: "Advanced, Strength, Weight Loss").call

    expect(result).not_to include(@exercise_description)
  end
end
