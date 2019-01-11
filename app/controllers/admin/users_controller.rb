class Admin::UsersController < Admin::ApplicationController
  def index
    @params = params
    @users = GetUsersService.new(@params).call
  end

  def destroy
    begin
      user = User.find(params[:id])
      user.destroy!
    rescue => e
      logger.error "[error] #{e.message}"
      flash[:danger] = "ユーザーの削除に失敗しました"
      redirect_back(fallback_location: admin_users_path) and return
    end
    flash[:success] = "ユーザーを削除しました"
    redirect_back(fallback_location: admin_users_path) and return
  end
end
