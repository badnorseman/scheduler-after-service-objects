class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: :index

  # GET /tags.json
  def index
    render json: policy_scope(Tag).order(:name), status: :ok
  end

  # GET /tags/1.json
  def show
    render json: @tag, status: :ok
  end

  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)
    @tag.user = current_user
    authorize @tag

    if @tag.save
      render json: @tag, status: :created
    else
      render json: { errors: @tag.errors }, status: :unprocessable_entity
    end
  end

  # PUT /tags/1.json
  def update
    if @tag.update(tag_params)
      render json: @tag, status: :ok
    else
      render json: { errors: @tag.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1.json
  def destroy
    if @tag.in_use?
      @tag.update(ended_at: Time.zone.now)
    else
      @tag.destroy
    end

    if @tag.errors.empty?
      head :no_content
    else
      render json: { errors: @tag.errors }
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_tag
    @tag = Tag.find(tag_id)
    authorize @tag
  end

  def tag_id
    params.fetch(:id)
  end
end
