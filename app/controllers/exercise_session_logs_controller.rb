class ExerciseSessionLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise_session_log, only: [:show, :update, :destroy]
  after_action :verify_authorized

  # GET /exercise_session_logs/1.json
  def show
    render json: @exercise_session_log, status: :ok
  end

  # POST /exercise_session_logs.json
  def create
    @exercise_session_log = ExerciseSessionLog.new(exercise_session_log_params)
    if current_user.coach?
      @exercise_session_log.coach = current_user
    else
      @exercise_session_log.user = current_user
    end
    authorize @exercise_session_log

    if @exercise_session_log.save
      render json: @exercise_session_log, status: :created
    else
      render json: { errors: @exercise_session_log.errors }, status: :unprocessable_entity
    end
  end

  # PUT /exercise_session_logs/1.json
  def update
    if @exercise_session_log.update(exercise_session_log_params)
      render json: @exercise_session_log, status: :ok
    else
      render json: { errors: @exercise_session_log.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /exercise_session_logs/1.json
  def destroy
    @exercise_session_log.destroy
    head :no_content
  end

  private

  def exercise_session_log_params
    params.require(:exercise_session_log).
      permit(:exercise_plan_log_id,
             :coach_id,
             :user_id,
             :started_at,
             :ended_at)
  end

  def set_exercise_session_log
    @exercise_session_log = ExerciseSessionLog.find(exercise_session_log_id)
    authorize @exercise_session_log
  end

  def exercise_session_log_id
    params.fetch(:id)
  end
end
