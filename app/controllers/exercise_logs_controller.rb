class ExerciseLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise_log, only: [:show, :update, :destroy]
  after_action :verify_authorized

  # GET /exercise_logs/1.json
  def show
    render json: @exercise_log, status: :ok
  end

  # POST /exercise_logs.json
  def create
    @exercise_log = ExerciseLog.new(exercise_log_params)
    if current_user.coach?
      @exercise_log.coach = current_user
    else
      @exercise_log.user = current_user
    end
    authorize @exercise_log

    if @exercise_log.save
      render json: @exercise_log, status: :created
    else
      render json: { errors: @exercise_log.errors }, status: :unprocessable_entity
    end
  end

  # PUT /exercise_logs/1.json
  def update
    if @exercise_log.update(exercise_log_params)
      render json: @exercise_log, status: :ok
    else
      render json: { errors: @exercise_log.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /exercise_logs/1.json
  def destroy
    @exercise_log.destroy
    head :no_content
  end

  private

  def exercise_log_params
    params.require(:exercise_log).
      permit(:exercise_description_id,
             :coach_id,
             :user_id,
             :distance,
             :duration,
             :load,
             :repetition,
             :rest,
             :tempo,
             :unilateral_execution,
             :unilateral_loading)
  end

  def set_exercise_log
    @exercise_log = ExerciseLog.find(exercise_log_id)
    authorize @exercise_log
  end

  def exercise_log_id
    params.fetch(:id)
  end
end
