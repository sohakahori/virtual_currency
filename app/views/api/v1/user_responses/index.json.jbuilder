json.set! :responses do
  json.array! @responses do |response|
    json.id response.id
    json.board_id response.board_id
    json.user_id response.user_id
    json.body response.body
    json.created_at response.created_at.iso8601
    json.created_at response.updated_at.iso8601
    json.set! :board do
      json.id response.board.id
      json.user_id response.board.user_id
      json.title response.board.title
      json.created_at response.board.created_at.iso8601
      json.updated_at response.board.updated_at.iso8601
    end
    json.set! :user do
      json.id response.user.id
      json.first_name response.user.first_name
      json.last_name response.user.last_name
      json.nickname response.user.nickname
      json.created_at response.user.created_at.iso8601
      json.updated_at response.user.updated_at.iso8601
    end
  end
end
json.partial! partial: 'api/v1/base/meta', locals: {collection: @responses}