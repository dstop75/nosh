class CartsController < ApplicationController
  before_filter :authenticate, only: [:index]
  before_action :set_cart, only: [:show, :update, :destroy]

  def index
    @carts = Cart.all

    render json: @carts
  end

  def show
    render json: @cart
  end

  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      render json: @cart, status: :created, location: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def update
    @cart = Cart.find(params[:id])

    if @cart.update(cart_params)
      head :no_content
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cart.destroy

    head :no_content
  end

  private

    def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params.require(:cart).permit(:user_id)
    end
end
