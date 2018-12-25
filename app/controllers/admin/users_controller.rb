class Admin::UsersController < Admin::ApplicationController
  def index
    @q = params[:q]
    @users = User
    if @q.present?
      @users = @users.search_first_name(@q)
          .or(@users.search_last_name(@q))
          .or(@users.search_first_name(@q))
          .or(@users.search_nickname(@q))
          .or(@users.search_full_name(@q))
          .or(@users.search_email(@q))
    end
    @users = @users.page(params[:page]).per(PER_PAGE)
  end
end
