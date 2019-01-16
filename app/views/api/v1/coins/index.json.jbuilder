json.coins do
  json.array! @coins do |coin|
    json.partial! coin
  end
end