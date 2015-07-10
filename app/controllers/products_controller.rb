class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_product, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: :index

  # GET /users/1/products.json
  def index
    render json: policy_scope(Product).order(:name), status: :ok
  end

  # GET /users/1/products/1.json
  def show
    render json: @product, status: :ok
  end

  # POST /users/1/products.json
  def create
    @product = @user.products.build(product_params)
    authorize @product

    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity, location: nil
    end
  end

  # PUT /users/1/products/1.json
  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity, location: nil
    end
  end

  # DELETE /users/1/products/1.json
  def destroy
    @product.destroy
    head :no_content
  end

  private

  def product_params
    params.require(:product).
      permit(:name,
             :description,
             :price,
             :currency_iso_code,
             :billing_day_of_month,
             :number_of_billing_cycles,
             :billing_frequency)
  end

  def set_user
    @user = User.find(user_id)
  end

  def set_product
    @product = @user.products.find(product_id)
    authorize @product
  end

  def user_id
    params.fetch(:user_id)
  end

  def product_id
    params.fetch(:id)
  end
end
