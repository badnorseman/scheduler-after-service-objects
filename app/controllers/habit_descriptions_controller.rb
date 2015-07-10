class HabitDescriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit_description, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: :index

  # GET /habit_descriptions.json
  def index
    render json: policy_scope(HabitDescription).order(:name), status: :ok
  end

  # GET /habit_descriptions/1.json
  def show
    render json: @habit_description, status: :ok
  end

  # POST /habit_descriptions.json
  def create
    @habit_description = HabitDescription.new(habit_description_params)
    @habit_description.user = current_user
    authorize @habit_description

    if @habit_description.save
      Tagger.new(user_id: current_user.id, taggable: @habit_description, tag_list: tag_list).call

      render json: @habit_description, status: :created
    else
      render json: { errors: @habit_description.errors }, status: :unprocessable_entity
    end
  end

  # PUT /habit_descriptions/1.json
  def update
    if @habit_description.update(habit_description_params)
      Tagger.new(user_id: current_user.id, taggable: @habit_description, tag_list: tag_list).call

      render json: @habit_description, status: :ok
    else
      render json: { errors: @habit_description.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /habit_descriptions/1.json
  def destroy
    if @habit_description.in_use?
      @habit_description.update(ended_at: Time.zone.now)
    else
      @habit_description.destroy
    end

    if @habit_description.errors.empty?
      head :no_content
    else
      render json: { errors: @habit_description.errors }
    end
  end

  private

  def habit_description_params
    params.require(:habit_description).
      permit(:name,
             :summary,
             :description,
             :tag_list)
  end

  def set_habit_description
    @habit_description = HabitDescription.find(habit_description_id)
    authorize @habit_description
  end

  def tag_list
    habit_description_params.fetch(:tag_list)
  end

  def habit_description_id
    params.fetch(:id)
  end
end
