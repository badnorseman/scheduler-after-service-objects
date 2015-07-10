class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: :index

  # GET /habits.json
  def index
    render json: policy_scope(Habit), status: :ok
  end

  # GET /habits/1.json
  def show
    render json: @habit, status: :ok
  end

  # POST /habits/1.json
  def create
    @habit = Habit.new(habit_params)
    authorize @habit

    if @habit.save
      render json: @habit, status: :created
    else
      render json: { errors: @habit.errors }, status: :unprocessable_entity, location: nil
    end
  end

  # PUT /habits/1.json
  def update
    if @habit.update(habit_params)
      render json: @habit, status: :ok
    else
      render json: { errors: @habit.errors }, status: :unprocessable_entity, location: nil
    end
  end

  # DELETE /habits/1.json
  def destroy
    @habit.destroy
    head :no_content
  end

  private

  def habit_params
    params.require(:habit).
      permit(:habit_description_id,
             :product_id,
             :user_id,
             :unit,
             :size)
  end

  def set_habit
    @habit = Habit.find(habit_id)
    authorize @habit
  end

  def habit_id
    params.fetch(:id)
  end
end
