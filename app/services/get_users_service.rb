class GetUsersService

  def initialize params
    @params = params
  end

  def call
    get_users
  end

  private
  attr_reader :params

  def get_users
    users = User
    if params[:q].present?
      users = users.search_first_name(params[:q])
                   .or(users.search_last_name(params[:q]))
                   .or(users.search_nickname(params[:q]))
                   .or(users.search_full_name(params[:q]))
                   .or(users.search_email(params[:q]))
    end
    users.page(params[:page]).per(Admin::ApplicationController::PER_PAGE)
  end
end