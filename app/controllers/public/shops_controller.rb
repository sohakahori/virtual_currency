class Public::ShopsController < Public::ApplicationController
  def index
    @q = params[:q]
    @coin_ids = params[:coin_ids]
    @coins = Coin.all
    @shops = Shop.eager_load(:coin_shops).eager_load(:coins)

    if @q.present?
      @shops = search_shops_prosess
    end

    if @coin_ids.present?
      @shops = search_coins_prosess
    end

    @shops = @shops.page(params[:page]).per(PER_PAGE)
  end

  def show
    @shop = Shop.find(params[:id])
  end

  private
  def search_shops_prosess
    @shops.search_name(@q)
        .or(@shops.search_address(@q))
        .or(@shops.search_company(@q))
  end

  def search_coins_prosess
    @shops.merge(Coin.coin_ids(@coin_ids))
  end
end
