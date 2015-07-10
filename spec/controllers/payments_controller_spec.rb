require "rails_helper"

describe PaymentsController, type: :controller do
  before do
    coach = create(:coach)
    @payment_plan = create(:payment_plan,
                           user: coach)
  end

  describe "GET #index" do
    it "should query 2 Payments" do
      user = create(:user)
      sign_in user
      payment = create_list(:payment,
                            2,
                            user: user).first
      get(:index)

      expect(json.count).to eq 2
    end
  end

  describe "GET #show" do
    it "should read 1 Payment" do
      user = create(:user)
      sign_in user
      payment = create(:payment,
                       user: user)
      get(
        :show,
        id: payment.id)

      expect(json["customer_id"]).to eq(payment.customer_id.as_json)
    end
  end

  describe "POST #create" do
    before do
      user = create(:user)
      sign_in user
    end

    context "with valid attributes" do
      it "should create Payment" do
        payment_attributes =
          attributes_for(:payment, payment_plan_id: @payment_plan.id)

        expect do
          post(
            :create,
            payment: payment_attributes)
        end.to change(Payment, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should not create Payment" do
        payment_attributes =
          attributes_for(:payment, payment_plan_id: nil)

        expect do
          post(
            :create,
            payment: payment_attributes)
        end.to change(Payment, :count).by(0)
      end
    end
  end

  describe "PATCH #update" do
    before do
      user = create(:user)
      @payment = create(:payment,
                        user: user)

      admin = create(:administrator)
      sign_in admin
    end

    context "with valid attributes" do
      it "should update Payment" do
        transaction_id =
          ([*('A'..'Z'), *('0'..'9')] - %w(0 1 I O)).sample(6).join

        patch(
          :update,
          id: @payment.id,
          payment: { transaction_id: transaction_id } )

        expect(Payment.find(@payment.id).transaction_id).to eq(transaction_id)
      end
    end

    context "with invalid attributes" do
      it "should not update Payment" do
        payment_plan_id = nil

        patch(
          :update,
          id: @payment.id,
          payment: { payment_plan_id: payment_plan_id } )

        expect(Payment.find(@payment.id).transaction_id).to eq(@payment.transaction_id)
      end
    end
  end

  describe "DELETE #destroy" do
    it "should delete Payment" do
      user = create(:user)
      payment = create(:payment,
                       user: user)
      admin = create(:administrator)
      sign_in admin

      expect do
        delete(
          :destroy,
          id: payment.id)
      end.to change(Payment, :count).by(-1)
    end
  end
end
