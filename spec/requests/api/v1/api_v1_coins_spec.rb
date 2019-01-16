require 'rails_helper'

RSpec.describe "Api::V1::Coins", type: :request do

  before do
    CreateAndUpdateCoinsService.new.create
  end

  describe "GET /coins" do
    it "200ステータスコードを返す" do
      get api_v1_coins_path
      expect(response).to have_http_status(200)
    end

    it "100件のレコードをレスポンスする" do
      get api_v1_coins_path
      json = JSON.parse(response.body)
      expect(Coin.count).to eq json["coins"].count
    end
  end
end
