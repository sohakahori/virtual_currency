json.set! :boards do
  json.array! @boards do |board|
    json.id board.id
    json.title board.title
    json.created_at board.created_at.iso8601
    json.created_at board.updated_at.iso8601
    json.set! :user do
      json.id board.user.id
      json.first_name board.user.first_name
      json.last_name board.user.last_name
      json.nickname board.user.nickname
      json.nickname board.user.nickname
      json.created_at board.user.created_at.iso8601
      json.updated_at board.user.updated_at.iso8601
    end
  end
end
json.partial! partial: 'api/v1/base/meta', locals: {collection: @boards}