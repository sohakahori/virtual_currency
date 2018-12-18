class Admin::AdminsController < Admin::ApplicationController
  before_action :get_adnin, only: [:show, :destroy]

  def index
    @q = params[:q]
    @admins = Admin
    if @q.present?
      @admins = @admins.search_first_name(@q).
          or(@admins.search_last_name(@q)).
          or(@admins.search_email(@q)).
          or(@admins.search_full_name(@q))
    end
    @admins = @admins.order_updated_at.page(params[:page]).per(PER_PAGE)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:success] = "管理者を登録しました"
      redirect_to admin_admins_path
    else
      flash.now[:danger] = "不正な入力値です"
      render :new
    end
  end

  def show
  end

  def destroy
    begin
      @admin.destroy!
    rescue => e
      logger.error "[error] #{e.message}"
      flash[:danger] = "管理者の削除に失敗しました"
      redirect_back(fallback_location: admin_admins_path) and return
    end
    flash[:success] = "管理者を削除しました"
    redirect_to admin_admins_path
  end

  private
  def admin_params
    params.require(:admin).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def get_adnin
    begin
      @admin = Admin.find(params[:id])
    rescue
      flash[:danger] = "不正なパラメータです"
      redirect_back(fallback_location: admin_admins_path) and return
    end
  end
end
