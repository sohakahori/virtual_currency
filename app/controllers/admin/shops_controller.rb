class Admin::ShopsController < Admin::ApplicationController
  def index
    @shops = Shop.page(params[:page]).per(PER_PAGE)
  end
end
