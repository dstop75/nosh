class OrdersController < ApplicationController
  before_filter :authenticate, only: [:index, :show, :update, :destroy]
  before_action :set_order, only: [:show, :update, :destroy]

  def index
    @orders = Order.all

    render json: @orders
  end

  def show
    render json: @order
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      head :no_content
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy

    head :no_content
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:user_id)
    end
end
