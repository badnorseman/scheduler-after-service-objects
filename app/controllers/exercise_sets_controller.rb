class ExerciseSetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise_set, only: [:show, :update, :destroy]
  after_action :verify_authorized

  # GET /exercise_sets/1.json
  def show
    render json: @exercise_set, status: :ok
  end

  # POST /exercise_sets.json
  def create
    @exercise_set = ExerciseSet.new(exercise_set_params)
    @exercise_set.user = current_user
    authorize @exercise_set

    if @exercise_set.save
      render json: @exercise_set, status: :created
    else
      render json: { errors: @exercise_set.errors }, status: :unprocessable_entity
    end
  end

  # PUT /exercise_sets/1.json
  def update
    if @exercise_set.update(exercise_set_params)
      render json: @exercise_set, status: :ok
    else
      render json: { errors: @exercise_set.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /exercise_sets/1.json
  def destroy
    @exercise_set.destroy
    head :no_content
  end

  private

  def exercise_set_params
    params.require(:exercise_set).
      permit(:exercise_session_id,
             :name,
             :duration)
  end

  def set_exercise_set
    @exercise_set = ExerciseSet.find(exercise_set_id)
    authorize @exercise_set
  end

  def exercise_set_id
    params.fetch(:id)
  end
end
