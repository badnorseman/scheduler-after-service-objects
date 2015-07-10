class RolesToUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_role, only: [:create, :destroy]
  before_action :set_user, only: [:create, :destroy]

  # POST /users/1/roles/1.json
  def create
    @user.roles << @role unless @user.roles.include?(@role)

    if @user.save
      head :no_content
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /users/1/roles/1.json
  def destroy
    @user.roles.destroy(@role) if @user.roles.find(@role)
    head :no_content
  end

  private

  def set_role
    @role = Role.find(role_id)
  end

  def set_user
    @user = User.find(user_id)
  end

  def role_id
    params.fetch(:role_id)
  end

  def user_id
    params.fetch(:id)
  end
end
