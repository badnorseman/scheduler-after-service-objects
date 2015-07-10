require "rails_helper"

describe PaymentPlan, type: :request do
  before do
    coach = create(:coach)
    @tokens = coach.create_new_auth_token("test")
    @payment_plan = create_list(:payment_plan,
                                2,
                                user: coach).first
  end

  describe "Unauthorized request" do
    before do
      get "/api/payment_plans.json"
    end

    it "should respond with status 401" do
      expect(response.status).to eq 401
    end
  end

  describe "GET #index" do
    before do
      get(
        "/api/payment_plans.json",
        {},
        @tokens)
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
      get(
        "/api/payment_plans/#{@payment_plan.id}.json",
        {},
        @tokens)
    end

    it "should respond with 1 PaymentPlan" do
      expect(json["name"]).to eq(@payment_plan.name)
    end

    it "should respond with status 200" do
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        @payment_plan_attributes = attributes_for(:payment_plan)

        post(
          "/api/payment_plans.json",
          { payment_plan: @payment_plan_attributes },
          @tokens)
      end

      it "should respond with created PaymentPlan" do
        expect(json["name"]).to eq @payment_plan_attributes[:name]
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
        payment_plan_attributes =
          attributes_for(:payment_plan, name: nil)

        post(
          "/api/payment_plans.json",
          { payment_plan: payment_plan_attributes },
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
    context "with valid attributes" do
      before do
        @name = "Name #{rand(100)}"

        patch(
          "/api/payment_plans/#{@payment_plan.id}.json",
          { payment_plan: { name: @name } },
          @tokens)
      end

      it "should respond with updated PaymentPlan" do
        expect(PaymentPlan.find(@payment_plan.id).name).to eq(@name)
      end

      it "should respond with status 200" do
        expect(response.status).to eq 200
      end
    end

    context "with invalid attributes" do
      before do
        name = "too long name" * 100

        patch(
          "/api/payment_plans/#{@payment_plan.id}.json",
          { payment_plan: { name: name } },
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
      delete(
        "/api/payment_plans/#{@payment_plan.id}.json",
        {},
        @tokens)
    end

    it "should respond with status 204" do
      expect(response.status).to eq 204
    end
  end
end
