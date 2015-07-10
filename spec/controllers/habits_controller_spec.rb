require 'rails_helper'

describe HabitsController, type: :controller do
  before do
    coach = create(:coach)
    sign_in coach
    @product = create(:product,
                      user: coach)
    @habit_description = create(:habit_description,
                                user: coach)
    @habit = create_list(:habit,
                         2,
                         product: @product,
                         habit_description: @habit_description).first
  end

  describe "GET #index" do
    before do
      another_coach = create(:coach)
      another_product = create(:product,
                               user: another_coach)
      another_habit_description = create(:habit_description,
                                         user: another_coach)
      create_list(:habit,
                  2,
                  product: another_product,
                  habit_description: another_habit_description)
    end

    it "should query 2 Habits" do
      get(:index)

      expect(json.count).to eq 2
    end
  end

  describe "GET #show" do
    it "should read 1 Habit" do
      get(
        :show,
        id: @habit.id)

      expect(json["habit_description_id"]).to eq(@habit.habit_description_id)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create Habit" do
        habit_attributes =
          attributes_for(:habit,
                         product_id: @product.id,
                         habit_description_id: @habit_description.id)
        expect do
          post(
            :create,
            habit: habit_attributes)
        end.to change(Habit, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create Habit" do
        habit_attributes =
          attributes_for(:habit,
                         product_id: @product.id,
                         habit_description_id: nil)
        expect do
          post(
            :create,
            habit: habit_attributes)
        end.to change(Habit, :count).by(0)
      end
    end
  end

    describe "PATCH #update" do
      context "with valid attributes" do
        it "should update Habit" do
          unit = "Kilogram"

          patch(
            :update,
            id: @habit.id,
            habit: { unit: unit } )

          expect(Habit.find(@habit.id).unit).to eq(unit)
        end
      end

      context "with invalid attributes" do
        it "should not update Habit" do
          unit = nil

          patch(
            :update,
            id: @habit.id,
            habit: { unit: unit } )

          expect(Habit.find(@habit.id).unit).to eq(@habit.unit)
        end
      end
    end

  describe "DELETE #destroy" do
    it "should delete Habit" do
      expect do
        delete(
          :destroy,
          id: @habit)
      end.to change(Habit, :count).by(-1)
    end
  end
end
