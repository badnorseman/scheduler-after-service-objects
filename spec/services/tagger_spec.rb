require "rails_helper"

describe Tagger do
  before do
    @user = create(:user)
    @exercise_description = create(:exercise_description)
    tag_list = "Beginner, Strength, Weight Loss"
    Tagger.new(user_id: @user.id, taggable: @exercise_description, tag_list: tag_list).call
  end

  context "when associate" do
    it "should create tagging" do
      tag_list = "Beginner, Strength, Weight Loss, Machines"

      expect { Tagger.new(user_id: @user.id, taggable: @exercise_description, tag_list: tag_list).call }.to change(Tagging, :count).by(1)
    end

    it "should create tag" do
      tag_list = "Beginner, Strength, Weight Loss, Machines"

      expect { Tagger.new(user_id: @user.id, taggable: @exercise_description, tag_list: tag_list).call }.to change(Tag, :count).by(1)
    end

    it "shouldn't create tags" do
      exercise_description = create(:exercise_description)
      tag_list = "Strength"

      expect { Tagger.new(user_id: @user.id, taggable: exercise_description, tag_list: tag_list).call }.to change(Tag, :count).by(0)
    end
  end

  context "when dissociate" do
    it "should delete tagging" do
      tag_list = "Strength, Weight Loss"

      expect { Tagger.new(user_id: @user.id, taggable: @exercise_description, tag_list: tag_list).call }.to change(Tagging, :count).by(-1)
    end

    it "shouldn't delete tags" do
      exercise_description = create(:exercise_description)
      tag_list = "Beginner, Weight Loss"
      Tagger.new(user_id: @user.id, taggable: exercise_description, tag_list: tag_list).call
      tag_list = "Strength"

      expect { Tagger.new(user_id: @user.id, taggable: @exercise_description, tag_list: tag_list).call }.to change(Tag, :count).by(0)
    end
  end
end
