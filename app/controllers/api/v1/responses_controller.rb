class Api::V1::ResponsesController < Api::V1::ApplicationController

  before_action :authenticate_user!
  before_action :get_board


  api :GET, '/v1/boards/:board_id/responses', 'コメント一覧を返します'
  description 'コメント一覧を返します'
  formats ['json']
  # error 401, 'Unauthorized'
  error code: 401, description: 'Unauthorized'

  header 'Content-Type', 'application/json', required: true
  header 'client', '6_fqbcH7qTO-4tGV81cOjw', required: true
  header 'access-token', 'dnLIrN5ADN_uAmmZIO1k8g', required: true
  header 'uid', 'test@test.com', required: true
  example <<-EDOC
  $ curl -H "Content-Type:application/json" -H "client:6_fqbcH7qTO-4tGV81cOjw" -H "access-token:dnLIrN5ADN_uAmmZIO1k8g" -H "uid:test@test.com" http://localhost/api/v1/boards/1/responses
  {
    "board": {
        "id": 1,
        "title": "スレッド名1",
        "created_at": "2019-01-19T18:26:23+09:00",
        "updated_at": "2019-01-19T18:26:23+09:00"
    },
    "responses": [
      {
        "id": 1,
        "body": "コメント1_1",
        "created_at": "2019-01-19T18:26:23+09:00",
        "user": {
          "id": 1,
          "first_name": "first_name1",
          "last_name": "last_name1",
          "nickname": "nickname1",
          "created_at": "2019-01-19T18:26:17+09:00",
          "updated_at": "2019-01-19T18:26:17+09:00"
        }
      },
      {
        "id": 2,
        "body": "コメント1_2",
        "created_at": "2019-01-19T18:26:23+09:00",
        "user": {
          "id": 1,
          "first_name": "first_name1",
          "last_name": "last_name1",
          "nickname": "nickname1",
          "created_at": "2019-01-19T18:26:17+09:00",
          "updated_at": "2019-01-19T18:26:17+09:00"
        }
      },
      {
        "id": 3,
        "body": "コメント1_3",
        "created_at": "2019-01-19T18:26:23+09:00",
        "user": {
          "id": 1,
          "first_name": "first_name1",
          "last_name": "last_name1",
          "nickname": "nickname1",
          "created_at": "2019-01-19T18:26:17+09:00",
          "updated_at": "2019-01-19T18:26:17+09:00"
        }
      }
    ],
    "meta": {
      "total_pages": 2,
      "current_page": 1,
      "total_count": 44,
      "limit_value": 30,
      "links": {
        "self": "http://localhost/api/v1/boards/1/responses?page%5Bnumber%5D=1&page%5Bsize%5D=30",
        "next": "http://localhost/api/v1/boards/1/responses?page%5Bnumber%5D=2&page%5Bsize%5D=30",
        "last": "http://localhost/api/v1/boards/1/responses?page%5Bnumber%5D=2&page%5Bsize%5D=30"
      }
    }
  }

  EDOC
  def index
    @responses = GetResponsesByBordService.new(params, @board, Api::V1::ApplicationController::PER_PAGE).call
    render 'index', formats: 'json', handlers: 'jbuilder'
  end


  api :POST, '/v1/boards/:board_id/responses', 'コメントを作成します'
  description 'コメントを作成します'
  formats ['json']
  error code: 400, description: 'Bad Request'
  error code: 401, description: 'Unauthorized'

  header 'Content-Type', 'application/json', required: true
  header 'client', '6_fqbcH7qTO-4tGV81cOjw', required: true
  header 'access-token', 'dnLIrN5ADN_uAmmZIO1k8g', required: true
  header 'uid', 'test@test.com', required: true
  example <<-EDOC
  $ curl -X POST -H "Content-Type:application/json" -H "client:6_fqbcH7qTO-4tGV81cOjw" -H "access-token:dnLIrN5ADN_uAmmZIO1k8g" -H "uid:test@test.com"  -d '{"response":{"body":"コメント"}}'  localhost/api/v1/boards/1/responses

  ## リクエストボディ
  {
	  "response": {
		  "body": "コメントだよ"
	  }
  }


  ## レスポンスボディ
  {
    "status": "success",
    "board": {
      "id": 1,
      "title": "スレッド名1",
      "created_at": "2019-01-19T18:26:23+09:00",
      "updated_at": "2019-01-19T18:26:23+09:00"
    },
    "response": {
      "id": 1607,
      "body": "コメントだよ",
      "board_id": 1,
      "user_id": 41,
      "created_at": "2019-01-19T23:49:11+09:00",
      "updated_at": "2019-01-19T23:49:11+09:00",
      "user": {
        "id": 41,
        "first_name": "first_name",
        "last_name": "last_name",
        "nickname": "nickname",
        "created_at": "2019-01-19T18:32:30+09:00",
        "updated_at": "2019-01-19T18:32:30+09:00"
      }
    }
  }

  ## レスポンスボディ(バリデーション時)
  {
    "errors": {
      "status": 400,
      "message": "Bad Request",
      "full_messages": [
        "コメントを入力してください"
      ]
    }
  }

  EDOC
  def create
    @response      = @board.responses.build(response_params)
    @response.user = current_user
    if @response.save
      render 'create', formats: 'json', handlers: 'jbuilder'
    else
      render_error Settings.status_code.bad_request, Settings.status_message.bad_request, @response.errors.full_messages
    end
  end




  api :DELETE, '/v1/boards/:board_id/response/:id', 'コメントを削除します'
  description 'コメントを削除します'
  formats ['json']
  error code: 401, description: 'Unauthorized'

  header 'Content-Type', 'application/json', required: true
  header 'client', '6_fqbcH7qTO-4tGV81cOjw', required: true
  header 'access-token', 'dnLIrN5ADN_uAmmZIO1k8g', required: true
  header 'uid', 'test@test.com', required: true
  example <<-EDOC
  $ curl -X POST -H "Content-Type:application/json" -H "client:6_fqbcH7qTO-4tGV81cOjw" -H "access-token:dnLIrN5ADN_uAmmZIO1k8g" -H "uid:test@test.com" localhost/api/v1/boards/1/responses/1

  ## リクエストボディ
  {}


  ## レスポンスボディ
  {
    "status": "success",
    "response": {
      "id": 1606,
      "body": "コメントだよ",
      "board_id": 1,
      "user_id": 41,
      "created_at": "2019-01-19T19:48:09+09:00",
      "updated_at": "2019-01-19T19:48:09+09:00"
    }
  }
  EDOC
  def destroy
    begin
      @response = @board.responses.find(params[:id])
      render_error Settings.status_code.bad_request, Settings.status_message.bad_request and return unless @response.user_id == current_user.id
      @response.destroy!
    rescue => e
      render_error Settings.status_code.internal_server_error, e.message and return
    end
    render 'destroy', formats: 'json', handlers: 'jbuilder'
  end

  private
  def get_board
    begin
      @board = Board.find(params[:board_id])
    rescue => e
      render_error Settings.status_code.internal_server_error, e.message
    end
  end

  def response_params
    params.require(:response).permit(:body)
  end
end
