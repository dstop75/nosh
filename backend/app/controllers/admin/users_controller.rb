class Admin::UsersController < ::UsersController
  before_filter :authenticate

  def index
    @users = User.all

    render json: @users
  end

end
