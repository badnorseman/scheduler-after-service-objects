require "rails_helper"

describe PaymentPlansController, type: :controller do
  before do
    coach = create(:coach)
    sign_in coach
    @payment_plan = create_list(:payment_plan,
                                2,
                                user: coach).first
  end

  describe "GET #index" do
    before do
      another_coach = create(:coach)
      create_list(:payment_plan,
                  2,
                  user: another_coach)
    end

    it "should query 2 PaymentPlans" do
      get(:index)

      expect(json.count).to eq 2
    end
  end

  describe "GET #show" do
    it "should read 1 PaymentPlan" do
      get(
        :show,
        id: @payment_plan.id)

      expect(json["name"]).to eq(@payment_plan.name)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "should create PaymentPlan" do
        payment_plan_attributes =
          attributes_for(:payment_plan)

        expect do
          post(
            :create,
            payment_plan: payment_plan_attributes)
        end.to change(PaymentPlan, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create PaymentPlan" do
        payment_plan_attributes =
          attributes_for(:payment_plan, name: nil)

        expect do
          post(
            :create,
            payment_plan: payment_plan_attributes)
        end.to change(PaymentPlan, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "should update PaymentPlan" do
        name = "Name #{rand(100)}"

        patch(
          :update,
          id: @payment_plan.id,
          payment_plan: { name: name } )

        expect(PaymentPlan.find(@payment_plan.id).name).to eq(name)
      end
    end

    context "with invalid attributes" do
      it "should not update PaymentPlan" do
        name = "too long name" * 10

        patch(
          :update,
          id: @payment_plan.id,
          payment_plan: { name: name } )

        expect(PaymentPlan.find(@payment_plan.id).name).to eq(@payment_plan.name)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete PaymentPlan" do
      expect do
        delete(
          :destroy,
          id: @payment_plan.id)
      end.to change(PaymentPlan, :count).by(-1)
    end
  end
end
