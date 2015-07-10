class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: :index

  # GET /users/1/payments.json
  def index
    render json: policy_scope(Payment).order(:transaction_id), status: :ok
  end

  # GET /users/1/payments/1.json
  def show
    render json: @payment, status: :ok
  end

  # POST /users/1/payments.json
  def create
    @payment = Payment.new(payment_params)
    @payment.user = current_user
    authorize @payment

    if @payment.save
      render json: @payment, status: :created
    else
      render json: { errors: @payment.errors }, status: :unprocessable_entity
    end
  end

  # PUT /users/1/payments/1.json
  def update
    if @payment.update(payment_params)
      render json: @payment, status: :ok
    else
      render json: { errors: @payment.errors }, status: :unprocessable_entity, location: nil
    end
  end

  # DELETE /users/1/payments/1.json
  def destroy
    @payment.destroy
    head :no_content
  end

  private

  def payment_params
    params.require(:payment).
      permit(:transaction_id,
             :customer_id,
             :payment_plan_id)
  end

  def set_payment
    @payment = Payment.find(payment_id)
    authorize @payment
  end

  def payment_id
    params.fetch(:id)
  end
end
