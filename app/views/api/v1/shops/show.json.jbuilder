json.name @shop.name
json.address @shop.address
json.company @shop.company
json.created_at @shop.created_at.iso8601
json.updated_at @shop.updated_at.iso8601
json.set! :coins do
  json.array! @shop.coins do |coin|
    json.partial! partial: 'api/v1/coins/coin', locals: {coin: coin}
  end
end