namespace :db do
  desc "コイン(coins)のマスターデータをインサート"
  task :coins_create => :environment do
    begin
      uri = URI.parse("https://api.coinmarketcap.com/v1/ticker/?convert=JPY")
      json = Net::HTTP.get(uri) #NET::HTTPを利用してAPIを叩く
      result = JSON.parse(json) #返ってきたjsonデータをrubyの配列に変換

      coins = []
      result.each do |coin|
        coins << Coin.new(
            name: coin["name"],
            coin_market_cap_id: coin["id"],
            symbol: coin["symbol"],
            rank: coin["rank"],
            market_cap_jpy: coin["market_cap_jpy"]
        )
      end
      Coin.import coins
    rescue => e
      puts "処理失敗"
      p e.message
      next
    end
    puts "コインの登録が完了しました"
    next
  end
end
