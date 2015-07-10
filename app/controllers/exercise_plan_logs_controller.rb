class ExercisePlanLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise_plan_log, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: :index

  # GET /exercise_plan_logs.json
  def index
    render json: policy_scope(ExercisePlanLog), status: :ok
  end

  # GET /exercise_plan_logs/1.json
  def show
    render json: @exercise_plan_log, status: :ok
  end

  # POST /exercise_plan_logs.json
  def create
    @exercise_plan_log = ExercisePlanLog.new(exercise_plan_log_params)
    if current_user.coach?
      @exercise_plan_log.coach = current_user
    else
      @exercise_plan_log.user = current_user
    end
    authorize @exercise_plan_log

    if @exercise_plan_log.save
      render json: @exercise_plan_log, status: :created
    else
      render json: { errors: @exercise_plan_log.errors }, status: :unprocessable_entity
    end
  end

  # PUT /exercise_plan_logs/1.json
  def update
    if @exercise_plan_log.update(exercise_plan_log_params)
      render json: @exercise_plan_log, status: :ok
    else
      render json: { errors: @exercise_plan_log.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /exercise_plan_logs/1.json
  def destroy
    @exercise_plan_log.destroy
    head :no_content
  end

  private

  def exercise_plan_log_params
    params.require(:exercise_plan_log).
      permit(:user_id,
             :coach_id,
             :name,
             :note,
             :ended_at)
  end

  def set_exercise_plan_log
    @exercise_plan_log = ExercisePlanLog.find(exercise_plan_log_id)
    authorize @exercise_plan_log
  end

  def exercise_plan_log_id
    params.fetch(:id)
  end
end
