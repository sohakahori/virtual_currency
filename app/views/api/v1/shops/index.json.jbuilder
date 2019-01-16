json.set! :shops do
  json.array! @shops do |shop|
    json.name shop.name
    json.address shop.address
    json.company shop.company
    json.created_at shop.created_at.iso8601
    json.updated_at shop.updated_at.iso8601
  end
end

json.partial! partial: 'api/v1/base/meta', locals: {collection: @shops}


