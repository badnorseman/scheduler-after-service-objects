require "rails_helper"

describe ExerciseDescriptionsController, type: :controller do
  before do
    coach = create(:coach)
    sign_in coach
    @exercise_description = create_list(:exercise_description,
                                        2,
                                        user: coach).first
  end

  describe "GET #index" do
    it "should query 2 ExerciseDescriptions" do
      get(:index)

      expect(json.count).to eq 2
    end
  end

  describe "GET #show" do
    it "should read 1 ExerciseDescription" do
      get(
        :show,
        id: @exercise_description.id)

      expect(json["name"]).to eq(@exercise_description.name)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create ExerciseDescription" do
        exercise_description_attributes =
          attributes_for(:exercise_description, tag_list: "Beginner")

        expect do
          post(
            :create,
            exercise_description: exercise_description_attributes)
        end.to change(ExerciseDescription, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create ExerciseDescription" do
        exercise_description_attributes =
          attributes_for(:exercise_description,
                         name: nil)
        expect do
          post(
            :create,
            exercise_description: exercise_description_attributes)
        end.to change(ExerciseDescription, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update ExerciseDescription" do
        name = "Name #{rand(100)}"
        tag_list = "Strength"

        patch(
          :update,
          id: @exercise_description.id,
          exercise_description: { name: name, tag_list: tag_list } )

        expect(ExerciseDescription.find(@exercise_description.id).name).to eq(name)
      end
    end

    context "with invalid attributes" do
      it "should not update ExerciseDescription" do
        name = "too long name" * 10

        patch(
          :update,
          id: @exercise_description.id,
          exercise_description: { name: name } )

        expect(ExerciseDescription.find(@exercise_description.id).name).to eq(@exercise_description.name)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete ExerciseDescription when not in use" do
      expect do
        delete(
          :destroy,
          id: @exercise_description.id)
      end.to change(ExerciseDescription, :count).by(-1)
    end

    it "should not delete ExerciseDescription when in use" do
      create(:exercise_log,
             exercise_description: @exercise_description)

      expect do
        delete(
          :destroy,
          id: @exercise_description.id)
      end.to change(ExerciseDescription, :count).by(-1)

      expect(ExerciseDescription.where(id: @exercise_description.id).unscope(where: :id)).to exist
    end
  end
end
