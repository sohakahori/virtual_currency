json.set! :status, "success"
json.set! :board do
  json.title @board.title
  json.user_id @board.user_id
  json.created_at @board.created_at.iso8601
  json.updated_at @board.updated_at.iso8601
  json.set! :response do
    json.board_id @response.board_id
    json.user_id @response.user_id
    json.body @response.body
    json.created_at @response.created_at.iso8601
    json.updated_at @response.updated_at.iso8601
  end
end