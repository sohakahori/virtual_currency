class Api::V1::CoinsController < Api::V1::ApplicationController

  api :GET, '/v1/coins', 'コイン一覧を返す'
  formats ['json']
  # error code: 401, desc: 'Unauthorized'
  # error code: 404, desc: 'Not Found'

  # 利用例は example に記載
  example <<-EDOC
  $ curl http://localhost/api/vi/coins
  {
    "coins": [
      {
        "id": 1,
        "name": "Bitcoin",
        "symbol": "BTC",
        "rank": 1,
        "price_jpy": "396259.403366",
        "market_cap_jpy": "6928268753847",
        "created_at": "2019-01-16T14:43:27+09:00",
        "updated_at": "2019-01-16T14:43:27+09:00"
      },
      {
        "id": 2,
        "name": "XRP",
        "symbol": "XRP",
        "rank": 2,
        "price_jpy": "35.6547547853",
        "market_cap_jpy": "1463285579951",
        "created_at": "2019-01-16T14:43:27+09:00",
        "updated_at": "2019-01-16T14:43:27+09:00"
      },
      {
        "id": 3,
        "name": "Ethereum",
        "symbol": "ETH",
        "rank": 3,
        "price_jpy": "13287.4771195",
        "market_cap_jpy": "1387194772001",
        "created_at": "2019-01-16T14:43:27+09:00",
        "updated_at": "2019-01-16T14:43:27+09:00"
      },
      {
        "id": 4,
        "name": "Bitcoin Cash",
        "symbol": "BCH",
        "rank": 4,
        "price_jpy": "14004.5152563",
        "market_cap_jpy": "246042877747",
        "created_at": "2019-01-16T14:43:27+09:00",
        "updated_at": "2019-01-16T14:43:27+09:00"
      }
    ]
  }
  EDOC
  def index
    @coins = Coin.all
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
