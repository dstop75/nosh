class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @products = Product.all

    render json: @products
  end

  def show
    render json: @product
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :image_url)
    end
end
