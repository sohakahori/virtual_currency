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




  api :POST, '/boards', 'スレッド一覧を返します'
  description 'スレッド一覧を返します'
  formats ['json']
  error code: 400, description: 'Bad Request'
  error code: 401, description: 'Unauthorized'

  header 'Content-Type', 'application/json', required: true
  header 'client', '6_fqbcH7qTO-4tGV81cOjw', required: true
  header 'access-token', 'dnLIrN5ADN_uAmmZIO1k8g', required: true
  header 'uid', 'test@test.com'
  # def_param_group :board do
  #   param :board, Hash, :action_aware => true, :required => true do
  #     param :title, String, :required => true
  #     param :responses_attributes, Array, :action_aware => true, :required => true do
  #       param :body, String, :required => true
  #     end
  #   end
  # end

  # param_group :board


  example <<-EDOC
  $ curl -X POST -H "Content-Type:application/json" -H "client:6_fqbcH7qTO-4tGV81cOjw" -H "access-token:dnLIrN5ADN_uAmmZIO1k8g" -H "uid:test@test.com"  -d '{"board":{"title":"スレッド名", "responses_attributes":[{"body":"コメント"}]}}'  0.0.0.0/api/v1/board

  ## リクエストボディ
  {
    "board" : {
      "title": "タイトル",
      "responses_attributes" : [
         {
            "body": "コメント"
         }
      ]
    } 
  }


  ## レスポンスボディ
  {
    "status": "success",
    "board": {
      "title": "タイトル",
      "user_id": 41,
      "created_at": "2019-01-18T17:39:06+09:00",
      "updated_at": "2019-01-18T17:39:06+09:00",
      "response": {
        "board_id": 53,
        "user_id": 41,
        "body": "コメント",
        "created_at": "2019-01-18T17:39:06+09:00",
        "updated_at": "2019-01-18T17:39:06+09:00"
      }
    }
  }

  ## レスポンスボディ(バリデーション時)
  {
    "errors": {
      "status": 400,
      "message": "Bad Request",
      "full_messages": [
        "コメントを入力してください",
        "スレッド名を入力してください"
      ]
    }
  }

  EDOC
  def create
    render_error Settings.status_code.bad_request, Settings.status_message.bad_request and return  if board_params[:responses_attributes].length != 1
    @board = current_user.boards.build(board_params)
    @board.responses[0].user = current_user
    if @board.save
      @response = @board.responses.last
      render 'create', formats: 'json', handlers: 'jbuilder'
    else
      render_error Settings.status_code.bad_request, Settings.status_message.bad_request, @board.errors.full_messages
    end
  end


  private
  def board_params
    params.require(:board).permit( :title, responses_attributes:[:body] )
  end

end
