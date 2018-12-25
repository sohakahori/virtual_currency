class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.page(params[:page]).per(PER_PAGE)
  end
end
