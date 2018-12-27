# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# FIXME: rake db:coins_createコマンドが無限ループしてしまう
# マスタデータ(API経由でダータをインサート)
# require 'rake'
# Rails.application.load_tasks
# Rake::Task['db:coins_create'].execute
# Rake::Task['db:coins_create'].clear



shop1 = Shop.create!(name: "コインチェック", address: "東京都渋谷区神泉2-18-9", company: "株式会社コインチェック")
shop2 = Shop.create!(name: "ビットフライヤー", address: "東京都みn区神泉2-18-9", company: "株式会社コインチェック")

(1..40).each do |n|
  Shop.create!(name: "取引所メイ#{n}", address: Faker::Address.full_address, company: Faker::Company.name)
end

CoinShop.create!(shop: shop1, coin: Coin.first)
CoinShop.create!(shop: shop1, coin: Coin.second)
CoinShop.create!(shop: shop1, coin: Coin.third)
CoinShop.create!(shop: shop2, coin: Coin.first)
CoinShop.create!(shop: shop2, coin: Coin.second)
CoinShop.create!(shop: shop2, coin: Coin.third)

(1..40).each do |i|
  Admin.create!(first_name: "first_name#{i}", last_name: "last_name#{i}", email: "test_email#{i}@test.com", password: "testtest")
end

user = User.create!(first_name: "first_name1", last_name: "last_name1", nickname: "nickname1", email: "test_email1@test.com", password: "testtest")
(2..40).each do |i|
  User.create!(first_name: "first_name#{i}", last_name: "last_name#{i}", nickname: "nickname#{i}", email: "test_email#{i}@test.com", password: "testtest")
end

(1..40).each do |i|
  board = Board.create!(title: "スレッド名#{i}", user: user)
  (1..40).each do |s|
    Response.create!(body: "コメント#{i}_#{s}", user: user, board: board)
  end
end




