require "rails_helper"

describe Payment, type: :request do
  before do
    coach = create(:coach)
    @payment_plan = create(:payment_plan,
                           user: coach)
  end

  describe "Unauthorized request" do
    before do
      get "/api/payments.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #index" do
    before do
      user = create(:user)
      tokens = user.create_new_auth_token("test")
      create_list(:payment,
                  2,
                  user: user).first
      get(
        "/api/payments.json",
        {},
        tokens)
    end

    it "should respond with an array of 2 PaymentPlans" do
      expect(json.count).to eq 2
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    before do
      user = create(:user)
      tokens = user.create_new_auth_token("test")
      @payment = create(:payment,
                        user: user)
      get(
        "/api/payments/#{@payment.id}.json",
        {},
        tokens)
    end

    it "should respond with 1 Payment" do
      expect(json["customer_id"]).to eq(@payment.customer_id.as_json)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    before do
      user = create(:user)
      @tokens = user.create_new_auth_token("test")
    end

    context "with valid attributes" do
      before do
        @payment_attributes =
          attributes_for(:payment,
                         payment_plan_id: @payment_plan.id)
        post(
          "/api/payments.json",
          { payment: @payment_attributes},
          @tokens)
      end

      it "should respond with created Payment" do
        expect(json["transaction_id"]).to eq @payment_attributes[:transaction_id]
      end

      it "should respond with new id" do
        expect(json.keys).to include("id")
      end

      it "should respond with status 201" do
        expect(response.status).to eq 201
      end
    end

    context "with invalid attributes" do
      before do
        payment_attributes =
          attributes_for(:payment,
                         payment_plan_id: @payment_plan.id,
                         transaction_id: nil)
        post(
          "/api/payments.json",
          { payment: payment_attributes },
          @tokens)
      end

      it "should respond with errors" do
        expect(json.keys).to include("errors")
      end

      it "should respond with status 422" do
        expect(response.status).to eq 422
      end
    end
  end

  describe "PATCH #update" do
    before do
      user = create(:user)
      @payment = create(:payment,
                        user: user)
      admin = create(:administrator)
      @tokens = admin.create_new_auth_token("test")
    end

    context "with valid attributes" do
      before do
        @transaction_id =
          ([*('A'..'Z'),*('0'..'9')]-%w(0 1 I O)).sample(6).join

        patch(
          "/api/payments/#{@payment.id}.json",
          { payment: { transaction_id: @transaction_id } },
          @tokens)
      end

      it "should respond with updated PaymentPlan" do
        expect(Payment.find(@payment.id).transaction_id).to eq(@transaction_id)
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        patch(
          "/api/payments/#{@payment.id}.json",
          { payment: { transaction_id: "" } },
          @tokens)
      end

      it "should respond with errors" do
        expect(json.keys).to include("errors")
      end

      it "should respond with status 422" do
        expect(response.status).to eq 422
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      user = create(:user)
      @payment = create(:payment,
                        user: user)
      admin = create(:administrator)
      @tokens = admin.create_new_auth_token("test")

      delete(
        "/api/payments/#{@payment.id}.json",
        {},
        @tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
