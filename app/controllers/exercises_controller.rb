class ExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise, only: [:show, :update, :destroy]
  after_action :verify_authorized

  # GET /exercises/1.json
  def show
    render json: @exercise, status: :ok
  end

  # POST /exercises.json
  def create
    @exercise = Exercise.new(exercise_params)
    @exercise.user = current_user
    authorize @exercise

    if @exercise.save
      render json: @exercise, status: :created
    else
      render json: { errors: @exercise.errors }, status: :unprocessable_entity
    end
  end

  # PUT /exercises/1.json
  def update
    if @exercise.update(exercise_params)
      render json: @exercise, status: :ok
    else
      render json: { errors: @exercise.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /exercises/1.json
  def destroy
    @exercise.destroy
    head :no_content
  end

  private

  def exercise_params
    params.require(:exercise).
      permit(:distance,
             :duration,
             :load,
             :repetition,
             :rest,
             :tempo,
             :distance_selected,
             :duration_selected,
             :load_selected,
             :repetition_selected,
             :unilateral_execution,
             :unilateral_loading,
             :exercise_set_id,
             :exercise_description_id)
  end

  def set_exercise
    @exercise = Exercise.find(exercise_id)
    authorize @exercise
  end

  def exercise_id
    params.fetch(:id)
  end
end
