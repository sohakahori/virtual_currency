class GetAdminsService
  def initialize params
    @params = params
  end

  def call
    get_admins
  end

  private
  attr_reader :params

  def get_admins
    admins = Admin
    if params[:q].present?
      admins = admins.search_first_name(params[:q]).
          or(admins.search_last_name(params[:q])).
          or(admins.search_email(params[:q])).
          or(admins.search_full_name(params[:q]))
    end
    admins.order_updated_at.page(params[:page]).per(Admin::ApplicationController::PER_PAGE)
  end

end