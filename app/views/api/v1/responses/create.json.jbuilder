json.status "success"

json.set! :board do
  json.id @board.id
  json.title @board.title
  json.created_at @board.created_at.iso8601
  json.updated_at @board.updated_at.iso8601
end

json.set! :response do
  json.id  @response.id
  json.body  @response.body
  json.board_id @response.board_id
  json.user_id @response.user_id
  json.created_at @response.created_at.iso8601
  json.updated_at @response.updated_at.iso8601
  json.set! :user do
    json.id @response.user.id
    json.first_name @response.user.first_name
    json.last_name @response.user.last_name
    json.nickname @response.user.nickname
    json.created_at @response.user.created_at.iso8601
    json.updated_at @response.user.updated_at.iso8601
  end
end
