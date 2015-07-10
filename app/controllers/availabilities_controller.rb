class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_availability, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: :index

  # GET /availabilities.json
  def index
    render json: policy_scope(Availability), status: :ok
  end

  # GET /availabilities/1.json
  def show
    render json: @availability, status: :ok
  end

  # POST /availabilities.json
  def create
    @availability = Availability.new(availability_params)
    @availability.coach = current_user
    @availability.recurring_calendar_days = recurring_calendar_days
    authorize @availability

    if @availability.save
      render json: @availability, status: :created
    else
      render json: { errors: @availability.errors }, status: :unprocessable_entity
    end
  end

  # PUT /availabilities/1.json
  def update
    @availability.assign_attributes(availability_params)
    @availability.recurring_calendar_days = recurring_calendar_days

    if @availability.save
      render json: @availability, status: :ok
    else
      render json: { errors: @availability.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /availabilities/1.json
  def destroy
    @availability.destroy
    head :no_content
  end

  private

  def availability_params
    params.require(:availability).
      permit(:start_at,
             :end_at,
             :beginning_of_business_day,
             :end_of_business_day,
             :duration,
             :auto_confirmation,
             :recurring_calendar_days,
             :cancellation_period,
             :late_cancellation_fee,
             :maximum_of_participants,
             :priority)
  end

  def recurring_calendar_days
    params[:availability][:recurring_calendar_days]
  end

  def set_availability
    @availability = Availability.find(availability_id)
    authorize @availability
  end

  def availability_id
    params.fetch(:id)
  end
end
