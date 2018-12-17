class Admin::ShopsController < Admin::ApplicationController

  before_action :get_shop, only: [:show, :edit, :update]

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


  private
  def shop_params
    params.require(:shop).permit(:name, :address, :company, coin_ids: [])
  end

  def get_shop
    @shop = Shop.find(params[:id])
  end
end
