class Api::V1::ShopsController < Api::V1::ApplicationController

  api :GET, 'v1/shops', '取引所一覧を返します'
  description '取引所一覧を返します'
  formats ['json']
  param :q, String, :desc => "取引所名・住所・会社名"
  param :coin_ids, Array, :desc => "[1, 2, 3]"
  example <<-EDOC
  $ curl http://localhost:3000/shops?q=コインチェック&coins_ids=[1, 2]
    {
    "shops": [
      {
        "name": "コインチェック",
        "address": "東京都渋谷区神泉2-18-9",
        "company": "株式会社コインチェック",
        "created_at": "2019-01-16T20:50:05+09:00",
        "updated_at": "2019-01-16T20:50:05+09:00",
        "coins": [
          {
            "id": 1,
            "name": "Bitcoin",
            "symbol": "BTC",
            "rank": 1,
            "price_jpy": "398431.560002",
            "market_cap_jpy": "6966411274404",
            "created_at": "2019-01-16T20:50:05+09:00",
            "updated_at": "2019-01-16T20:50:05+09:00"
          },
          {
            "id": 2,
            "name": "XRP",
            "symbol": "XRP",
            "rank": 2,
            "price_jpy": "36.1899421435",
            "market_cap_jpy": "1485249885936",
            "created_at": "2019-01-16T20:50:05+09:00",
            "updated_at": "2019-01-16T20:50:05+09:00"
          },
          {
            "id": 3,
            "name": "Ethereum",
            "symbol": "ETH",
            "rank": 3,
            "price_jpy": "13529.1527337",
            "market_cap_jpy": "1412482493278",
            "created_at": "2019-01-16T20:50:05+09:00",
            "updated_at": "2019-01-16T20:50:05+09:00"
          }
        ]
      },
      {
        "name": "ビットフライヤー",
        "address": "東京都みn区神泉2-18-9",
        "company": "株式会社コインチェック",
        "created_at": "2019-01-16T20:50:05+09:00",
        "updated_at": "2019-01-16T20:50:05+09:00",
        "coins": [
          {
            "id": 1,
            "name": "Bitcoin",
            "symbol": "BTC",
            "rank": 1,
            "price_jpy": "398431.560002",
            "market_cap_jpy": "6966411274404",
            "created_at": "2019-01-16T20:50:05+09:00",
            "updated_at": "2019-01-16T20:50:05+09:00"
          },
          {
            "id": 2,
            "name": "XRP",
            "symbol": "XRP",
            "rank": 2,
            "price_jpy": "36.1899421435",
            "market_cap_jpy": "1485249885936",
            "created_at": "2019-01-16T20:50:05+09:00",
            "updated_at": "2019-01-16T20:50:05+09:00"
          },
          {
            "id": 3,
            "name": "Ethereum",
            "symbol": "ETH",
            "rank": 3,
            "price_jpy": "13529.1527337",
            "market_cap_jpy": "1412482493278",
            "created_at": "2019-01-16T20:50:05+09:00",
            "updated_at": "2019-01-16T20:50:05+09:00"
          }
        ]
      }
    ],
    "meta": {
      "total_pages": 1,
      "current_page": 1,
      "total_count": 2,
      "limit_value": 30,
      "links": {
          "self": "http://0.0.0.0/api/v1/shops?page%5Bnumber%5D=1&page%5Bsize%5D=2&q=%E3%82%B3%E3%82%A4%E3%83%B3%E3%83%81%E3%82%A7%E3%83%83%E3%82%AF"
      }
    }
  EDOC

  def index
    coin_ids = params[:coin_ids].present? ?  params[:coin_ids]: nil
    # Todo パラメータのリファクタリング
    @shops         = GetShopsService.new(params, coin_ids).call
    set_query_string_to_hash
    render 'index', formats: 'json', handlers: 'jbuilder'
  end


  api :GET, '/v1/shops/:id', '取引所を返します'
  description '取引所を返します'
  formats ['json']
  param :id, :number, desc: 'shop id', required: true
  example <<-EDOC
  $ curl http://localhost/api/vi/shops/1
  {
    "name": "コインチェック",
    "address": "東京都渋谷区神泉2-18-9",
    "company": "株式会社コインチェック",
    "created_at": "2019-01-16T20:50:05+09:00",
    "updated_at": "2019-01-16T20:50:05+09:00",
    "coins": [
      {
        "id": 1,
        "name": "Bitcoin",
        "symbol": "BTC",
        "rank": 1,
        "price_jpy": "398431.560002",
        "market_cap_jpy": "6966411274404",
        "created_at": "2019-01-16T20:50:05+09:00",
        "updated_at": "2019-01-16T20:50:05+09:00"
      },
      {
        "id": 2,
        "name": "XRP",
        "symbol": "XRP",
        "rank": 2,
        "price_jpy": "36.1899421435",
        "market_cap_jpy": "1485249885936",
        "created_at": "2019-01-16T20:50:05+09:00",
        "updated_at": "2019-01-16T20:50:05+09:00"
      },
      {
        "id": 3,
        "name": "Ethereum",
        "symbol": "ETH",
        "rank": 3,
        "price_jpy": "13529.1527337",
        "market_cap_jpy": "1412482493278",
        "created_at": "2019-01-16T20:50:05+09:00",
        "updated_at": "2019-01-16T20:50:05+09:00"
      }
    ]
}

  EDOC
  def show
    begin
      @shop = Shop.find(params[:id])
    rescue
      render_error 500, "idに紐づく取引所を取得できませんでした" and return
    end
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
end
