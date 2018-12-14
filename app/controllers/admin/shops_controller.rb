class Admin::ShopsController < Admin::ApplicationController
  def index
    @shops = Shop.page(params[:page]).per(PER_PAGE)
  end

  def new
    @shop = Shop.new()
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      flash[:success] = "取引所を登録しました"
      redirect_to admin_shops_path
    else
      flash.now[:danger] = "不正な入力値です"
      render :new
    end
  end

  private
  def shop_params
    params.require(:shop).permit(:name, :address, :company, coin_ids: [])
  end
end
