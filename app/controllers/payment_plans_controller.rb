class PaymentPlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment_plan, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: :index

  # GET /payment_plans.json
  def index
    render json: policy_scope(PaymentPlan).order(:name), status: :ok
  end

  # GET /payment_plans/1.json
  def show
    render json: @payment_plan, status: :ok
  end

  # POST /payment_plans.json
  def create
    @payment_plan = PaymentPlan.new(payment_plan_params)
    @payment_plan.user = current_user
    authorize @payment_plan

    if @payment_plan.save
      render json: @payment_plan, status: :created
    else
      render json: { errors: @payment_plan.errors }, status: :unprocessable_entity, location: nil
    end
  end

  # PUT /payment_plans/1.json
  def update
    if @payment_plan.update(payment_plan_params)
      render json: @payment_plan, status: :ok
    else
      render json: { errors: @payment_plan.errors }, status: :unprocessable_entity, location: nil
    end
  end

  # DELETE /payment_plans/1.json
  def destroy
    @payment_plan.destroy
    head :no_content
  end

  private

  def payment_plan_params
    params.require(:payment_plan).
      permit(:name,
             :description,
             :price,
             :currency_iso_code,
             :billing_day_of_month,
             :number_of_billing_cycles,
             :billing_frequency)
  end

  def set_payment_plan
    @payment_plan = PaymentPlan.find(payment_plan_id)
    authorize @payment_plan
  end

  def payment_plan_id
    params.fetch(:id)
  end
end
