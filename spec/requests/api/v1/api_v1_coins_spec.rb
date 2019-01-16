require 'rails_helper'

RSpec.describe "Api::V1::Coins", type: :request do

    # CreateAndUpdateCoinsService.new.create
  before do
    (1..10).each do
      FactoryBot.create(:coin)
    end
  end

  describe "GET /coins" do
    it "200ステータスコードを返す" do
      get api_v1_coins_path
      expect(response).to have_http_status(200)
    end

    it "全レコードをレスポンスする" do
      get api_v1_coins_path
      json = JSON.parse(response.body)
      expect(Coin.count).to eq json["coins"].count
    end
  end
end
