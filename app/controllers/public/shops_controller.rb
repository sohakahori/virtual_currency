class Public::ShopsController < Public::ApplicationController
  def index
    @params   = params
    @coin_ids = params[:coin_ids].present? ? params[:coin_ids] : []
    @coins    = Coin.all
    @shops    = GetShopsService.new(@params, @params[:coin_ids]).call
  end

  def show
    @shop = Shop.find(params[:id])
  end
end
