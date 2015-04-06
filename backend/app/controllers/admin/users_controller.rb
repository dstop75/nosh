class Admin::UsersController < ::UsersController
  before_filter :authenticate
  before_action :require_admin

  def index
    @users = User.all

    render json: @users
  end

end
