# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# マスタデータ
coin1 = Coin.create(name: "Bitcoin", name_kana: "ビットコイン", market_rank: "1")
coin2 = Coin.create!(name: "XRP", name_kana: "リップル", market_rank: "2")
coin3 = Coin.create!(name: "Ethereum", name_kana: "イーサリアム", market_rank: "3")
Coin.create!(name: "Stellar", name_kana: "ステラ", market_rank: "4")
Coin.create!(name: "Tether", name_kana: "テザー", market_rank: "5")
Coin.create!(name: "Bitcoin Cash", name_kana: "ビットコインキャッシュ", market_rank: "6")
Coin.create!(name: "EOS", name_kana: "イオス", market_rank: "7")
Coin.create!(name: "Bitcoin SV", name_kana: "ビットコイン SV", market_rank: "8")
Coin.create!(name: "Litecoin", name_kana: "ライトコイン", market_rank: "9")
Coin.create!(name: "TRON", name_kana: "トロン", market_rank: "10")
Coin.create!(name: "Cardano", name_kana: "カルダノ", market_rank: "11")
Coin.create!(name: "Monero", name_kana: "モネロ", market_rank: "12")
Coin.create!(name: "Binance Coin", name_kana: "バイナンスコイン", market_rank: "13")
Coin.create!(name: "NEM", name_kana: "ネム", market_rank: "14")
Coin.create!(name: "IOTA", name_kana: "アイオタ", market_rank: "15")


shop1 = Shop.create!(name: "コインチェック", address: "東京都渋谷区神泉2-18-9", company: "株式会社コインチェック")
shop2 = Shop.create!(name: "ビットフライヤー", address: "東京都みn区神泉2-18-9", company: "株式会社コインチェック")

(1..40).each do |n|
  Shop.create!(name: "取引所メイ#{n}", address: Faker::Address.full_address, company: Faker::Company.name)
end

CoinShop.create!(shop: shop1, coin: coin1)
CoinShop.create!(shop: shop1, coin: coin2)
CoinShop.create!(shop: shop1, coin: coin3)
CoinShop.create!(shop: shop2, coin: coin1)
CoinShop.create!(shop: shop2, coin: coin2)
CoinShop.create!(shop: shop2, coin: coin3)




