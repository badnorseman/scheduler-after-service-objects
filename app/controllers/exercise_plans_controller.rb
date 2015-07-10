class ExercisePlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise_plan, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: :index

  # GET /exercise_plans.json
  def index
    render json: policy_scope(ExercisePlan), status: :ok
  end

  # GET /exercise_plans/1.json
  def show
    render json: @exercise_plan, status: :ok
  end

  # POST /exercise_plans.json
  def create
    @exercise_plan = ExercisePlan.new(exercise_plan_params)
    @exercise_plan.user = current_user
    authorize @exercise_plan

    if @exercise_plan.save
      render json: @exercise_plan, status: :created
    else
      render json: { errors: @exercise_plan.errors }, status: :unprocessable_entity
    end
  end

  # PUT /exercise_plans/1.json
  def update
    if @exercise_plan.update(exercise_plan_params)
      render json: @exercise_plan, status: :ok
    else
      render json: { errors: @exercise_plan.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /exercise_plans/1.json
  def destroy
    @exercise_plan.destroy
    head :no_content
  end

  private

  def exercise_plan_params
    params.require(:exercise_plan).
      permit(:name,
             :description,
             :ended_at)
  end

  def set_exercise_plan
    @exercise_plan = ExercisePlan.find(exercise_plan_id)
    authorize @exercise_plan
  end

  def exercise_plan_id
    params.fetch(:id)
  end
end
