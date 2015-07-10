require "rails_helper"

describe HabitDescriptionsController, type: :controller do
  before do
    coach = create(:coach)
    sign_in coach
    @habit_description = create_list(:habit_description,
                                     2,
                                     user: coach).first
  end

  describe "GET #index" do
    before do
      another_coach = create(:coach)
      create_list(:habit_description,
                  2,
                  user: another_coach)
    end

    it "should query 2 HabitDescriptions" do
      get(:index)

      expect(json.count).to eq 2
    end
  end

  describe "GET #show" do
    it "should read 1 HabitDescription" do
      get(
        :show,
        id: @habit_description.id)

      expect(json["name"]).to eq(@habit_description.name)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create HabitDescription" do
        habit_description_attributes =
          attributes_for(:habit_description, tag_list: "")

        expect do
          post(
            :create,
            habit_description: habit_description_attributes)
        end.to change(HabitDescription, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create HabitDescription" do
        habit_description_attributes =
          attributes_for(:habit_description, name: nil)

        expect do
          post(
            :create,
            habit_description: habit_description_attributes)
        end.to change(HabitDescription, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update HabitDescription" do
        name = "Sleep #{rand(24)} hours daily"
        tag_list = ""

        patch(
          :update,
          id: @habit_description.id,
          habit_description: { name: name, tag_list: tag_list } )

        expect(HabitDescription.find(@habit_description.id).name).to eq(name)
      end
    end

    context "with invalid attributes" do
      it "should not update HabitDescription" do
        name = "too long name" * 10

        patch(
          :update,
          id: @habit_description.id,
          habit_description: { name: name } )

        expect(HabitDescription.find(@habit_description.id).name).to eq(@habit_description.name)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete HabitDescription when not in use" do
      expect do
        delete(
          :destroy,
          id: @habit_description.id)
      end.to change(HabitDescription, :count).by(-1)
    end

    it "should not delete HabitDescription when in use" do
      create(:habit_log,
             habit_description: @habit_description)

      expect do
        delete(
          :destroy,
          id: @habit_description.id)
      end.to change(HabitDescription, :count).by(-1)

      expect(HabitDescription.where(id: @habit_description.id).unscope(where: :id)).to exist
    end
  end
end
