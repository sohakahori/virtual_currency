class Admin::CoinsController < Admin::ApplicationController
  def index
    @coins = Coin.order_market_rank.all
  end
end
