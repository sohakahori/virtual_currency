class Admin::ShopsController < Admin::ApplicationController

  before_action :get_shop, only: [:show, :edit, :update, :destroy]

  def index
    @params = params
    @coin_ids = params[:coin_ids].present? ? params[:coin_ids] : []
    get_slhops_service = GetShopsService.new(@params, @coin_ids)
    @shops             = get_slhops_service.call
    @coins             = Coin.all
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

  def show
  end

  def eidt
  end

  def update
    CoinShop.destroy(@shop.coin_shops.ids)
    if @shop.update(shop_params)
      flash[:success] = "取引所を更新しました"
      redirect_to admin_shop_path
    else
      flash.now[:danger] = "不正な入力値です"
      render :edit
    end
  end

  def destroy
    begin
      @shop.destroy!
    rescue => e
      flash[:danger] = "取引所の削除に失敗しました"
      logger.error "[error] #{e.message}"
      redirect_back(fallback_location: admin_shops_path) and return
    end
    flash[:success] = "取引所を削除しました"
    redirect_to admin_shops_path
  end


  private
  def shop_params
    params.require(:shop).permit(:name, :address, :company, coin_ids: [])
  end

  def get_shop
    @shop = Shop.find(params[:id])
  end
end
