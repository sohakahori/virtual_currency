namespace :db do
  desc "コイン(coins)のマスターデータをインサート"
  task :coins_create => :environment do
    begin
      api_coins = get_coins_info
      coins = []
      api_coins.each do |coin|
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

  desc "コイン(coins)のマスターデータをアップデート"
  task :coins_update => :environment do
    begin
      api_coins = get_coins_info
      update_coins = []
      Coin.all.each do |coin|
        api_coins.each do |api_coin|
          if coin.coin_market_cap_id == api_coin["id"]
            coin.name = api_coin["name"]
            coin.symbol = api_coin["symbol"]
            coin.rank = api_coin["rank"]
            coin.market_cap_jpy = api_coin["market_cap_jpy"]
            update_coins << coin
          end
        end
      end
      Coin.import update_coins, on_duplicate_key_update:[:name, :symbol, :rank, :market_cap_jpy]
    rescue => e
      CoinUpdateNotificationMailer.notification_nosuccess_email().deliver
      puts "処理失敗"
      p e.message
      next
    end
    CoinUpdateNotificationMailer.notification_success_email().deliver
    puts "コインの更新が完了しました"
    next
  end

  private
  def get_coins_info
    uri = URI.parse("https://api.coinmarketcap.com/v1/ticker/?convert=JPY")
    json = Net::HTTP.get(uri) #NET::HTTPを利用してAPIを叩く
    JSON.parse(json) #返ってきたjsonデータをrubyの配列に変換
  end
end
