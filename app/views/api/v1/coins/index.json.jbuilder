json.coins do
  json.array! @coins do |coin|
    json.id coin.id
    json.name  coin.name
    json.symbol  coin.symbol
    json.rank  coin.rank
    json.price_jpy  coin.price
    json.market_cap_jpy  coin.market_cap_jpy
    json.created_at  coin.created_at.iso8601
    json.updated_at  coin.updated_at.iso8601
  end
end