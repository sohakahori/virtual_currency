class Api::V1::ShopsController < Api::V1::ApplicationController

  def index
    coin_ids = params[:coin_ids].present? ?  params[:coin_ids]: nil
    # Todo パラメータのリファクタリング
    @shops   = GetShopsService.new(params, coin_ids).call
    @coins   = Coin.all
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    begin
      @shop = Shop.find(params[:id])
    rescue
      errors 505, "idに紐づく取引所を取得できませんでした" and return
    end
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
end
