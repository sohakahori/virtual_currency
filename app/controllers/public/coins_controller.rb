class Public::CoinsController < ApplicationController

  def index
    @coins = Coin.all
  end
end
