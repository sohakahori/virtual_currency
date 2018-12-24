class Public::CoinsController < Public::ApplicationController

  def index
    @coins = Coin.all
  end
end
