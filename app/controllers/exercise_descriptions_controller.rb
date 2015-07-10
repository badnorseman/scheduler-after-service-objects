class ExerciseDescriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise_description, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: :index

  # GET /exercise_descriptions.json
  def index
    render json: policy_scope(ExerciseDescription).order(:name), status: :ok
  end

  # GET /exercise_descriptions/1.json
  def show
    render json: @exercise_description, status: :ok
  end

  # POST /exercise_descriptions.json
  def create
    @exercise_description = ExerciseDescription.new(exercise_description_params)
    @exercise_description.user = current_user
    authorize @exercise_description

    if @exercise_description.save
      Tagger.new(user_id: current_user.id, taggable: @exercise_description, tag_list: tag_list).call

      render json: @exercise_description, status: :created
    else
      render json: { errors: @exercise_description.errors }, status: :unprocessable_entity
    end
  end

  # PUT /exercise_descriptions/1.json
  def update
    if @exercise_description.update(exercise_description_params)
      Tagger.new(user_id: current_user.id, taggable: @exercise_description, tag_list: tag_list).call

      render json: @exercise_description, status: :ok
    else
      render json: { errors: @exercise_description.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /exercise_descriptions/1.json
  def destroy
    if @exercise_description.in_use?
      @exercise_description.update(ended_at: Time.zone.now)
    else
      @exercise_description.destroy
    end

    if @exercise_description.errors.empty?
      head :no_content
    else
      render json: { errors: @exercise_description.errors }
    end
  end

  private

  def exercise_description_params
    params.require(:exercise_description).
      permit(:name,
             :short_name_for_mobile,
             :description,
             :distance,
             :duration,
             :load,
             :repetition,
             :tempo,
             :video_url,
             :unilateral_execution,
             :unilateral_loading,
             :tag_list)
  end

  def set_exercise_description
    @exercise_description = ExerciseDescription.find(exercise_description_id)
    authorize @exercise_description
  end

  def tag_list
    exercise_description_params.fetch(:tag_list)
  end

  def exercise_description_id
    params.fetch(:id)
  end
end
