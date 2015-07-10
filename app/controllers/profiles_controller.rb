class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :create, :update]
  before_action :set_profile, only: [:show, :update]
  after_action :verify_authorized

  # GET /users/1/profile.json
  def show
    render json: @profile, status: :ok
  end

  # POST /users/1/profile.json
  def create
    @profile = @user.build_profile(profile_params)
    authorize @profile

    if @profile.save
      render json: @profile, status: :created
    else
      render json: { errors: @profile.errors }, status: :unprocessable_entity
    end
  end

  # PUT /users/1/profile.json
  def update
    if @profile.update(profile_params)
      render json: @profile, status: :ok
    else
      render json: { errors: @profile.errors }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).
      permit(:first_name,
             :last_name,
             :company,
             :address1,
             :address2,
             :postal_code,
             :city,
             :state_province,
             :country,
             :phone_number,
             :gender,
             :birth_date,
             :height,
             :weight)
  end

  def set_profile
    @profile = @user.profile
    authorize @profile
  end

  def set_user
    @user = User.find(user_id)
  end

  def user_id
    params.fetch(:id)
  end
end
