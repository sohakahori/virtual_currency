require 'rails_helper'

RSpec.describe "Api::V1::Shops", type: :request do

  let!(:shop) { FactoryBot.create(:shop) }
  describe "GET /api/v1/shops" do
    it "200スタータスコードを返す" do
      get api_v1_shops_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/shops/:id" do
    it "200スタータスコードを返す" do
      get api_v1_shop_path(shop)
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq shop.name
    end
  end
end
