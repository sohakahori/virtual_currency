class Api::V1::ShopsController < ApplicationController

  def index
    coin_ids = params[:coin_ids].present? ?  params[:coin_ids]: nil
    # Todo パラメータのリファクタリング
    @shops   = GetShopsService.new(params, coin_ids).call
    @coins   = Coin.all
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
