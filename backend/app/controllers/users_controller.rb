class UsersController < ApplicationController
  before_filter :authenticate, only: [:index, :show, :update, :destroy]
  before_action :set_user, only: [:show, :update, :destroy]

  def sign_in
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: {token: user.token, id: user.id}, status: :accepted
    else
      head :unauthorized
    end
  end

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: { token: user.token, id: user.id }, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    head :no_content
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :token)
    end
end
