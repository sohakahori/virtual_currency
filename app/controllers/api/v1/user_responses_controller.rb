class Api::V1::UserResponsesController < Api::V1::ApplicationController


  api :GET, '/v1/user_responses', '投稿コメント一覧を返します'
  description '投稿コメント一覧を返します'
  formats ['json']
  error code: 401, description: 'Unauthorized'

  header 'Content-Type', 'application/json', required: true
  header 'client', '6_fqbcH7qTO-4tGV81cOjw', required: true
  header 'access-token', 'dnLIrN5ADN_uAmmZIO1k8g', required: true
  header 'uid', 'test@test.com', required: true
  param :q, String, :required => false
  example <<-EDOC
  $ curl -H "Content-Type:application/json" -H "client:6_fqbcH7qTO-4tGV81cOjw" -H "access-token:dnLIrN5ADN_uAmmZIO1k8g" -H "uid:test@test.com" http://localhost/api/v1/user_responses
  {
    "responses": [
      {
        "id": 1613,
        "board_id": 1,
        "user_id": 41,
        "body": "aaaa",
        "created_at": "2019-01-20T18:47:03+09:00",
        "board": {
          "id": 1,
          "user_id": 1,
          "title": "スレッド名1",
          "created_at": "2019-01-19T18:26:23+09:00",
          "updated_at": "2019-01-19T18:26:23+09:00"
        },
        "user": {
          "id": 41,
          "first_name": "first_name",
          "last_name": "last_name",
          "nickname": "nickname",
          "created_at": "2019-01-19T18:32:30+09:00",
          "updated_at": "2019-01-19T18:32:30+09:00"
        }
      },
      {
        "id": 1612,
        "board_id": 1,
        "user_id": 41,
        "body": "aaaa",
        "created_at": "2019-01-20T18:47:01+09:00",
        "board": {
          "id": 1,
          "user_id": 1,
          "title": "スレッド名1",
          "created_at": "2019-01-19T18:26:23+09:00",
          "updated_at": "2019-01-19T18:26:23+09:00"
        },
        "user": {
          "id": 41,
          "first_name": "first_name",
          "last_name": "last_name",
          "nickname": "nickname",
          "created_at": "2019-01-19T18:32:30+09:00",
          "updated_at": "2019-01-19T18:32:30+09:00"
        }
      }
    ],
    "meta": {
      "total_pages": 1,
      "current_page": 1,
      "total_count": 11,
      "limit_value": 15,
      "links": {
        "self": "http://localhost/api/v1/user_responses?page%5Bnumber%5D=1&page%5Bsize%5D=11"
      }
    }
}
  EDOC
  def index
    @responses = GetUserResponsesService.new(current_user, params).call
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
