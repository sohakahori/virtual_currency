class Api::V1::BoardsController < Api::V1::ApplicationController
  before_action :authenticate_user!



  api :GET, '/boards', 'スレッド一覧を返します'
  description 'スレッド一覧を返します'
  formats ['json']
  # error 401, 'Unauthorized'
  error code: 401, description: 'Unauthorized'

  header 'Content-Type', 'application/json', required: true
  header 'client', '6_fqbcH7qTO-4tGV81cOjw', required: true
  header 'access-token', 'dnLIrN5ADN_uAmmZIO1k8g', required: true
  header 'uid', 'test@test.com'

  param :q, String, :desc => "スレッド1 スレッド2"


  example <<-EDOC
  $ curl http://localhost/api/v1/boards?q=スレッド1 スレッド2
  {
    "boards": [
      {
        "id": 30,
        "title": "スレッド名30",
        "created_at": "2019-01-17T20:35:25+09:00",
        "user": {
          "id": 1,
          "first_name": "first_name1",
          "last_name": "last_name1",
          "nickname": "nickname1",
          "created_at": "2019-01-17T20:35:14+09:00",
          "updated_at": "2019-01-17T20:35:14+09:00"
        }
      },
      {
        "id": 31,
        "title": "スレッド名31",
        "created_at": "2019-01-17T20:35:25+09:00",
        "user": {
          "id": 1,
          "first_name": "first_name1",
          "last_name": "last_name1",
          "nickname": "nickname1",
          "created_at": "2019-01-17T20:35:14+09:00",
          "updated_at": "2019-01-17T20:35:14+09:00"
        }
      }
    ],
    "meta": {
      "total_pages": 1,
      "current_page": 1,
      "total_count": 2,
      "limit_value": 30,
      "links": {
        "self": "http://0.0.0.0/api/v1/boards?page%5Bnumber%5D=1&page%5Bsize%5D=2&q=%E3%82%B9%E3%83%AC%E3%83%83%E3%83%89%E5%90%8D30+%E3%82%B9%E3%83%AC%E3%83%83%E3%83%89%E5%90%8D31"
      }
    }
}
  EDOC
  def index
    @boards = GetBoardsService.new(params).call
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
