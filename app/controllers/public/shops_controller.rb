class Public::ShopsController < Public::ApplicationController
  def index
    @shops = Shop.page(params[:page]).per(PER_PAGE)
  end

  def show
    @shop = Shop.find(params[:id])
  end
end
