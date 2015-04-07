class Admin::ProductsController < ::ProductsController
  before_filter :authenticate
  before_action :require_admin
  before_action :set_product, only: [:update, :destroy]

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy

    head :no_content
  end
end
