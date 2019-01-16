class Api::V1::ShopsController < Api::V1::ApplicationController

  def index
    coin_ids = params[:coin_ids].present? ?  params[:coin_ids]: nil
    # Todo パラメータのリファクタリング
    @shops         = GetShopsService.new(params, coin_ids).call
    @query_strings = get_query_string_to_hash
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    begin
      @shop = Shop.find(params[:id])
    rescue
      render_error 500, "idに紐づく取引所を取得できませんでした" and return
    end
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
end
