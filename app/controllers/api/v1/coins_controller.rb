class Api::V1::CoinsController < Api::V1::ApplicationController

  def index
    @coins = Coin.all
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
