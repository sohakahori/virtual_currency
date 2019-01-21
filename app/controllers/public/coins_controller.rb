class Public::CoinsController < Public::ApplicationController

  def index
    @coins = Coin.order_market_rank
  end
end
