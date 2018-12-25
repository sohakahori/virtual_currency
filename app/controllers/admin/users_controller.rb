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

  def destroy
    begin
      user = User.find(params[:id])
      user.destroy!
    rescue => e
      flash[:danger] = "ユーザーの削除に失敗しました"
      redirect_back(fallback_location: admin_users_path) and return
    end
    logger.error "[error] #{e.message}"
    flash[:success] = "ユーザーを削除しました"
    redirect_back(fallback_location: admin_users_path) and return
  end
end
