class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_role, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: :index

  # GET /roles.json
  def index
    render json: policy_scope(Role).order(:name), status: :ok
  end

  # GET /roles/1.json
  def show
    render json: @role, status: :ok
  end

  # POST /roles.json
  def create
    @role = Role.new(role_params)
    authorize @role

    if @role.save
      render json: @role, status: :created
    else
      render json: { errors: @role.errors }, status: :unprocessable_entity
    end
  end

  # PUT /roles/1.json
  def update
    if @role.update(role_params)
      render json: @role, status: :ok
    else
      render json: { errors: @role.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /roles/1.json
  def destroy
    @role.destroy
    head :no_content
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

  def set_role
    @role = Role.find(role_id)
    authorize @role
  end

  def role_id
    params.fetch(:id)
  end
end
