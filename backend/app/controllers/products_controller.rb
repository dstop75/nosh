class ProductsController < ApplicationController
  before_filter :authenticate, only: [:create, :update, :destroy]
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = Product.all

    render json: @products
  end

  def show
    render json: @product
  end

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
      head :no_content
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy

    head :no_content
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :image_url)
    end
end
