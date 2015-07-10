class ExerciseSetLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise_set_log, only: [:show, :update, :destroy]
  after_action :verify_authorized

  # GET /exercise_set_logs/1.json
  def show
    render json: @exercise_set_log, status: :ok
  end

  # POST /exercise_set_logs.json
  def create
    @exercise_set_log = ExerciseSetLog.new(exercise_set_log_params)
    if current_user.coach?
      @exercise_set_log.coach = current_user
    else
      @exercise_set_log.user = current_user
    end
    authorize @exercise_set_log

    if @exercise_set_log.save
      render json: @exercise_set_log, status: :created
    else
      render json: { errors: @exercise_set_log.errors }, status: :unprocessable_entity
    end
  end

  # PUT /exercise_set_logs/1.json
  def update
    if @exercise_set_log.update(exercise_set_log_params)
      render json: @exercise_set_log, status: :ok
    else
      render json: { errors: @exercise_set_log.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /exercise_set_logs/1.json
  def destroy
    @exercise_set_log.destroy
    head :no_content
  end

  private

  def exercise_set_log_params
    params.require(:exercise_set_log).
      permit(:coach_id,
             :user_id,
             :exercise_session_log_id,
             :rest,
             :duration)
  end

  def set_exercise_set_log
    @exercise_set_log = ExerciseSetLog.find(exercise_set_log_id)
    authorize @exercise_set_log
  end

  def exercise_set_log_id
    params.fetch(:id)
  end
end
