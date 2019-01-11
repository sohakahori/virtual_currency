class GetShopsService

  def initialize params, checked_coin_ids
    @params           = params
    @checked_coin_ids = checked_coin_ids
  end

  def call
    get_shops
  end

  private
  attr_reader :params, :checked_coin_ids

  def get_shops
    shops = Shop.eager_load(:coin_shops).eager_load(:coins)
    if params[:q].present?
      shops = shops.search_name(params[:q]).or(shops.search_address(params[:q])).or(shops.search_company(params[:q]))
    end
    if checked_coin_ids.present?
      shops = shops.merge(Coin.coin_ids(checked_coin_ids))
    end
    shops.page(params[:page]).per(Admin::ApplicationController::PER_PAGE)
  end
end