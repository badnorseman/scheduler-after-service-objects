class HabitLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit_log, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: :index

  # GET /habit_logs.json
  def index
    render json: policy_scope(HabitLog), status: :ok
  end

  # GET /habit_logs/1.json
  def show
    render json: @habit_log, status: :ok
  end

  # POST /habit_logs.json
  def create
    @habit_log = HabitLog.new(habit_log_params)
    @habit_log.user = current_user
    authorize @habit_log

    if @habit_log.save
      render json: @habit_log, status: :created
    else
      render json: { errors: @habit_log.errors }, status: :unprocessable_entity
    end
  end

  # PUT /habit_logs/1.json
  def update
    if @habit_log.update(habit_log_params)
      render json: @habit_log, status: :ok
    else
      render json: { errors: @habit_log.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /habit_logs/1.json
  def destroy
    if @habit_log.logged?
      @habit_log.update(ended_at: Time.zone.now)
    else
      @habit_log.destroy
    end

    if @habit_log.errors.empty?
      head :no_content
    else
      render json: { errors: @habit_log.errors }
    end
  end

  private

  def habit_log_params
    params.require(:habit_log).
      permit(:habit_description_id,
             { :logged_at => [] })
  end

  def set_habit_log
    @habit_log = HabitLog.find(habit_log_id)
    authorize @habit_log
  end

  def habit_log_id
    params.fetch(:id)
  end
end
