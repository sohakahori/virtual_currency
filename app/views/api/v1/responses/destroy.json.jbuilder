json.status "success"

json.set! :response do
  json.id  @response.id
  json.body  @response.body
  json.board_id @response.board_id
  json.user_id @response.user_id
  json.created_at @response.created_at.iso8601
  json.updated_at @response.updated_at.iso8601
end
