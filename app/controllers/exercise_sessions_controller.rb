class ExerciseSessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise_session, only: [:show, :update, :destroy]
  after_action :verify_authorized

  # GET /exercise_sessions/1.json
  def show
    render json: @exercise_session, status: :ok
  end

  # POST /exercise_sessions.json
  def create
    @exercise_session = ExerciseSession.new(exercise_session_params)
    @exercise_session.user = current_user
    authorize @exercise_session

    if @exercise_session.save
      render json: @exercise_session, status: :created
    else
      render json: { errors: @exercise_session.errors }, status: :unprocessable_entity
    end
  end

  # PUT /exercise_sessions/1.json
  def update
    if @exercise_session.update(exercise_session_params)
      render json: @exercise_session, status: :ok
    else
      render json: { errors: @exercise_session.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /exercise_sessions/1.json
  def destroy
    @exercise_session.destroy
    head :no_content
  end

  private

  def exercise_session_params
    params.require(:exercise_session).
      permit(:exercise_plan_id,
             :name)
  end

  def set_exercise_session
    @exercise_session = ExerciseSession.find(exercise_session_id)
    authorize @exercise_session
  end

  def exercise_session_id
    params.fetch(:id)
  end
end
